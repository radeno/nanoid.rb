# nanoid.rb

A tiny, secure URL-friendly unique string ID generator.

Ruby implementation of original NanoID https://github.com/ai/nanoid

# Usage

## Default settings:

Size: 22 character length

Alphabet: _~0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ


## Simple generate unique string:

```ruby
require 'nanoid'

Nanoid.generate
```

## Change length of generated string

```ruby
require 'nanoid'

Nanoid.generate(size: 10)
```

## Change alphabet of generated string

```ruby
require 'nanoid'

Nanoid.generate(alphabet: '1234567890abcdef')
```

## Change size and alphabet of generated string

```ruby
require 'nanoid'

Nanoid.generate(size: 14, alphabet: '1234567890abcdef')
```
