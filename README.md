# nanoid.rb

This is ReadMe for version 2.0, if you looking for version compatible with nanoid.js 1.x look on [branch v1.x.](https://github.com/radeno/nanoid.rb/tree/v1.x)

A tiny, secure URL-friendly unique string ID generator.

Ruby implementation of original NanoID https://github.com/ai/nanoid

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
