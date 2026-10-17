require 'securerandom'

module Nanoid
  SAFE_ALPHABET = '_-0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.freeze

  def self.generate(size: 21, alphabet: SAFE_ALPHABET, non_secure: false)
    size = normalize_size(size)
    return '' if size.zero?

    return non_secure_generate(size, alphabet) if non_secure

    return simple_generate(size) if alphabet == SAFE_ALPHABET

    complex_generate(size, alphabet)
  end

  private

  # Mirrors upstream NanoID's handling of a non-integer/negative `size`:
  # truncate floats instead of looping forever, and fail fast on negative
  # sizes instead of raising a cryptic SecureRandom error later on.
  def self.normalize_size(size)
    raise ArgumentError, "size must be a number, got #{size.class}" unless size.is_a?(Numeric)

    size = size.to_i
    # Integer#negative? arrived in Ruby 2.3.
    raise ArgumentError, 'size must not be negative' if size < 0

    size
  end

  def self.validate_alphabet!(alphabet)
    raise ArgumentError, 'alphabet must not be empty' if alphabet.empty?
  end

  def self.simple_generate(size)
    bytes = random_bytes(size)

    (0...size).reduce('') do |acc, i|
      acc << SAFE_ALPHABET[bytes[i] & 63]
    end
  end

  def self.complex_generate(size, alphabet)
    validate_alphabet!(alphabet)

    alphabet_size = alphabet.size
    # A single-character alphabet has no entropy to extract a mask from
    # (and would hit a Math::DomainError below), so short-circuit it.
    return alphabet[0] * size if alphabet_size == 1

    mask = alphabet_mask(alphabet_size)
    step = (1.6 * mask * size / alphabet_size).ceil

    id = ''

    loop do
      # Request `step` bytes (not `size`), matching upstream: `step` is
      # always >= the number of bytes actually consumed per iteration, so
      # this avoids wasted extra loop iterations/SecureRandom calls caused
      # by indexing past a too-small buffer (which silently yields `nil`).
      bytes = random_bytes(step)
      (0...step).each do |idx|
        byte = bytes[idx] & mask
        character = byte && alphabet[byte]
        if character
          id << character
          return id if id.size == size
        end
      end
    end
  end

  def self.non_secure_generate(size, alphabet)
    validate_alphabet!(alphabet)

    alphabet_size = alphabet.size

    id = ''

    size.times do
      id << alphabet[(Random.rand * alphabet_size).floor]
    end

    id
  end

  def self.random_bytes(size)
    SecureRandom.random_bytes(size).bytes
  end

  # Smallest bitmask of the form 2**n - 1 that covers every alphabet index.
  # Integer shifts only: `2 << float` raises TypeError on Ruby 2.0.
  def self.alphabet_mask(alphabet_size)
    limit = 1
    limit <<= 1 while limit <= alphabet_size - 1
    limit - 1
  end
end
