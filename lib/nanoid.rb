# frozen_string_literal: true

require 'securerandom'
require 'random/formatter' # Gives `Random` the same `.alphanumeric` as `SecureRandom`.

module Nanoid
  SAFE_ALPHABET = '_-0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.freeze

  def self.generate(size: 21, alphabet: SAFE_ALPHABET, non_secure: false)
    validate_alphabet!(alphabet)
    size = normalize_size(size)
    return '' if size.zero?

    chars = alphabet.chars
    # `Random::Formatter#choose` (what `.alphanumeric` calls under the hood)
    # loops forever on a single-character source: its growth check
    # `limit *= size` never advances when `size == 1`. Short-circuit it.
    return chars.first * size if chars.size == 1

    (non_secure ? Random : SecureRandom).alphanumeric(size, chars: chars)
  end

  private

  def self.validate_alphabet!(alphabet)
    # An empty source hits the same infinite loop as a single-character one.
    raise ArgumentError, 'alphabet must not be empty' if alphabet.empty?
  end

  # Ruby's own `.alphanumeric` truncates a float and silently returns ''
  # for a negative size; we truncate the same way but raise instead, so a
  # caller finds a mistake immediately rather than getting a short ID.
  def self.normalize_size(size)
    raise ArgumentError, "size must be a number, got #{size.class}" unless size.is_a?(Numeric)

    size = size.to_i
    raise ArgumentError, 'size must not be negative' if size.negative?

    size
  end
end
