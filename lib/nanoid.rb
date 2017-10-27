# frozen_string_literal: true

require 'securerandom'

module Nanoid
  SAFE_ALPHABET = '_~0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

  def self.generate(size: 21, alphabet: SAFE_ALPHABET)
    return simple_generate(size: size) if alphabet == SAFE_ALPHABET

    complex_generate(size: size, alphabet: alphabet)
  end

  def self.simple_generate(size:)
    bytes = random_bytes(size)

    (0...size).reduce('') do |acc, i|
      acc + SAFE_ALPHABET[bytes[i] & 63]
    end
  end

  def self.complex_generate(size:, alphabet:)
    alphabet_size = alphabet.size
    mask = (2 << Math.log(alphabet_size - 1) / Math.log(2)) - 1
    step = (1.6 * mask * size / alphabet_size).ceil

    id = ''
    catch :computed do
      loop do
        bytes = random_bytes(size)
        (0...step).each do |i|
          byte = bytes[i] & mask
          character = byte && alphabet[byte]
          if character
            id = "#{id}#{character}"
            throw :computed if id.size == size
          end
        end
      end
    end

    id
  end

  def self.random_bytes(size)
    SecureRandom.random_bytes(size).bytes
  end
end
