require_relative 'test_helper'

describe Nanoid do
  it 'has correct size' do
    count = 100

    count.times do
      id = Nanoid.generate

      assert_equal(id.size, 22)
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

  it 'has no collisions' do
    count = 1_000_000
    generated = []

    count.times do
      id = Nanoid.generate

      refute generated.include?(id)
      generated << id
    end
  end

  it 'generates with custom settings' do
    Nanoid.generate(size: 12, alphabet: '1234567890abcdef')
  end
end
