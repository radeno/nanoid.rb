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
    count = 100_000
    generated = {}

    count.times do
      id = Nanoid.generate

      refute generated.key?(id), "generated #{generated.keys.size} entries"
      generated[id] = true
    end
  end

  it 'has no collisions for milion entries with 9 characters and base alphabet' do
    count = 100_000
    generated = {}

    count.times do
      id = Nanoid.generate(size: 9, alphabet: '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')

      refute generated.key?(id), "generated #{generated.keys.size} entries"
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
end
