# frozen_string_literal: true

require_relative 'test_helper'

describe Nanoid do
  it 'has correct size' do
    count = 100

    count.times do
      id = Nanoid.generate

      assert_equal(id.size, 21)
    end
  end

  it 'generates URL-friendly IDs' do
    count = 100

    count.times do
      id = Nanoid.generate

      (0...id.size).each do |j|
        refute_nil Nanoid::SAFE_ALPHABET.index(id[j])
      end
    end
  end

  it 'has no collisions for million entries as 21 characters length' do
    count = 1_000_000
    generated = {}

    count.times do
      id = Nanoid.generate

      # NOTE: `generated.size` (O(1)) is used instead of `generated.keys.size`
      # (O(n)) in the failure message, since minitest evaluates it eagerly on
      # every call regardless of outcome; using `.keys` here would turn this
      # loop into an O(n^2) operation.
      refute generated.key?(id), "generated #{generated.size} entries"
      generated[id] = true
    end
  end

  it 'has no collisions for milion entries with 9 characters and base alphabet' do
    count = 1_000_000
    generated = {}

    count.times do
      id = Nanoid.generate(size: 9, alphabet: '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')

      refute generated.key?(id), "generated #{generated.size} entries"
      generated[id] = true
    end
  end

  it 'generates with custom settings' do
    assert_kind_of(String, Nanoid.generate(size: 12, alphabet: '1234567890abcdef'))
  end

  it 'generates non secure' do
    assert_kind_of(String, Nanoid.generate(non_secure: true))
  end

  it 'generates non secure with options' do
    assert_equal('aaaaa', Nanoid.generate(size: 5, alphabet: 'a', non_secure: true))
  end

  it 'returns empty string for zero size with default alphabet' do
    assert_equal('', Nanoid.generate(size: 0))
  end

  it 'returns empty string for zero size with custom alphabet' do
    assert_equal('', Nanoid.generate(size: 0, alphabet: '1234567890abcdef'))
  end

  it 'returns empty string for zero size when non secure' do
    assert_equal('', Nanoid.generate(size: 0, non_secure: true))
  end

  it 'truncates non-integer size with default alphabet' do
    assert_equal(10, Nanoid.generate(size: 10.9).size)
  end

  it 'truncates non-integer size with custom alphabet' do
    assert_equal(10, Nanoid.generate(size: 10.9, alphabet: '1234567890abcdef').size)
  end

  it 'truncates non-integer size when non secure' do
    assert_equal(10, Nanoid.generate(size: 10.9, non_secure: true).size)
  end

  it 'raises for negative size with default alphabet' do
    assert_raises(ArgumentError) { Nanoid.generate(size: -1) }
  end

  it 'raises for negative size with custom alphabet' do
    assert_raises(ArgumentError) { Nanoid.generate(size: -1, alphabet: '1234567890abcdef') }
  end

  it 'raises for non-numeric size' do
    assert_raises(ArgumentError) { Nanoid.generate(size: '21') }
  end

  it 'raises for empty custom alphabet' do
    assert_raises(ArgumentError) { Nanoid.generate(size: 5, alphabet: '') }
  end

  it 'raises for empty custom alphabet when non secure' do
    assert_raises(ArgumentError) { Nanoid.generate(size: 5, alphabet: '', non_secure: true) }
  end

  it 'repeats the single character of a one-character alphabet' do
    assert_equal('aaaaa', Nanoid.generate(size: 5, alphabet: 'a'))
  end

  it 'generates correct size with a two-character alphabet' do
    id = Nanoid.generate(size: 50, alphabet: 'ab')

    assert_equal(50, id.size)
    assert_empty(id.chars - %w[a b])
  end
end
