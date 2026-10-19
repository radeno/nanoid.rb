# nanoid.rb

**Version 3.0 is not released.** `gem install nanoid` still installs 2.0.1. Read that version's documentation in the [v2.x README](https://github.com/radeno/nanoid.rb/blob/v2.x/README.md).

On Ruby 3.3+ the same 21-character ID can be made without this gem:

```ruby
alphabet = "_-0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
SecureRandom.alphanumeric(21, chars: alphabet.chars)
```

The published 2.0.1 implementation is faster. Both calls below use size 21 and the default NanoID alphabet (`benchmark-ips`, 2s warmup, 5s run, Ruby 3.3.12, arm64):

| call | iterations/sec | time per ID |
| --- | ---: | ---: |
| `Nanoid.generate` (Ruby >= 2.0) | 366,029 | 2.73 μs |
| `SecureRandom.alphanumeric` (Ruby >= 3.3) | 205,100 | 4.88 μs |

`SecureRandom.alphanumeric` is 1.78× slower.

The rest of this page describes unreleased 3.0 work on `master`. It requires Ruby >= 3.3. For NanoID 1.x compatibility, see [branch v1.x](https://github.com/radeno/nanoid.rb/tree/v1.x).

A tiny, secure URL-friendly unique string ID generator.

Ruby implementation of original NanoID https://github.com/ai/nanoid

Starting with 3.0, `Nanoid.generate` is a thin wrapper around Ruby's own
`SecureRandom.alphanumeric`/`Random.alphanumeric` (stdlib, Ruby >= 3.3),
rather than a hand-rolled random ID algorithm. It still fixes a couple of
edge cases those stdlib methods get wrong: a single-character or empty
`alphabet` makes `Random::Formatter#choose` loop forever, and a negative
`size` is silently returned as `''` instead of raising.

# Installation

Into Gemfile / gems.rb add:

`gem 'nanoid'`

# Usage

```ruby
require 'nanoid'

Nanoid.generate
```

## Options

| parameter    | type    | description                                                             |
| ------------ | ------- | ----------------------------------------------------------------------- |
| `size`       | integer | Length of generated string                                              |
| `alphabet`   | string  | Collection of characters used for generated string                      |
| `non_secure` | boolean | Switch to use non-secure generated string. Do not use if you don't need |

### Default options:

Size: 21 character length

Alphabet: \_-0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ

Non secure: false

## Examples

### Simple generate unique string

```ruby
require 'nanoid'

Nanoid.generate
# => "MVNBLMwrcdbKjpo73qsmN"
```

### Change length of generated string

```ruby
require 'nanoid'

Nanoid.generate(size: 10)
# => "zRTPzok801"
```

### Change alphabet of generated string

```ruby
require 'nanoid'

Nanoid.generate(alphabet: '1234567890abcdef')
# => "84e292c6aabbbf50bf087"
```

### Change size and alphabet of generated string

```ruby
require 'nanoid'

Nanoid.generate(size: 14, alphabet: '1234567890abcdef')
# => "c5db3470fadf94"
```

### Use non-secure generator

```ruby
require 'nanoid'

Nanoid.generate(non_secure: true)
# => "-BX3dH02BmRX9Al4drpIb"
```
