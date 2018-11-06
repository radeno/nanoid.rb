# frozen_string_literal: true

require 'securerandom'

module Nanoid
  SAFE_ALPHABET = '_-0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

  def self.generate(size: 21, alphabet: SAFE_ALPHABET, non_secure: false)
    return non_secure_generate(size: size, alphabet: alphabet) if non_secure

    return simple_generate(size: size) if alphabet == SAFE_ALPHABET

    complex_generate(size: size, alphabet: alphabet)
  end

  private

  def self.simple_generate(size:)
    bytes = random_bytes(size)

    (0...size).reduce(''.dup) do |acc, i|
      acc << SAFE_ALPHABET[bytes[i] & 63]
    end
  end

  def self.complex_generate(size:, alphabet:)
    alphabet_size = alphabet.size
    mask = (2 << Math.log(alphabet_size - 1) / Math.log(2)) - 1
    step = (1.6 * mask * size / alphabet_size).ceil

    id = ''.dup

    loop do
      bytes = random_bytes(size)
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

  def self.non_secure_generate(size:, alphabet:)
    alphabet_size = alphabet.size

    id = ''.dup

    size.times do
      id << alphabet[(Random.rand * alphabet_size).floor]
    end

    id
  end

  def self.random_bytes(size)
    SecureRandom.random_bytes(size).bytes
  end
end
