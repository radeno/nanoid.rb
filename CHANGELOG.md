# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [3.0.0] - 2026-10-17

### Changed

- **Breaking:** Minimum Ruby version raised to 3.3.
- `Nanoid.generate` is now a thin wrapper around `SecureRandom.alphanumeric`/`Random.alphanumeric` (stdlib, via the `chars:` keyword added in Ruby 3.3) instead of a hand-rolled rejection-sampling algorithm. Same default `size` (21) and `alphabet`, same `non_secure` option.
- Dev dependencies (`benchmark-ips`, `minitest`, `rake`) are no longer pinned to old releases; the Ruby 2.0 constraint that required that is gone.

### Fixed

- `Random::Formatter#choose` (what `.alphanumeric` calls) loops forever on a single-character or empty `alphabet` — its growth check never advances when the source has 0 or 1 elements. `Nanoid.generate` now short-circuits both cases instead of hanging.
- A negative `size` now raises `ArgumentError` instead of silently returning `''` (stdlib's own behavior).

## [2.0.1] - 2026-10-17

### Fixed

- Fixed infinite loop in `Nanoid.generate` with a custom `alphabet` when `size` is `0` or a non-integer (ported fix from upstream NanoID's handling of these cases).
- Kept the implementation on Ruby 2.0: no `Integer#negative?` (Ruby 2.3), no required keyword arguments (Ruby 2.1), and the alphabet mask is computed with integer shifts.
- Fixed `Math::DomainError`/`FloatDomainError` when using a custom `alphabet` with 0 or 1 characters.
- Raise a clear `ArgumentError` for a negative `size`, a non-numeric `size`, or an empty `alphabet`, instead of a cryptic internal error.

### Changed

- Development dependencies are limited to the last releases that still run on Ruby 2.0: `benchmark-ips` 2.7.2, `minitest` 5.11.3, and `rake` 12.3.3. `bundler`, `reek`, and `rubocop` are no longer dependencies. Ruby 3.4 and newer also install `mutex_m` and `ostruct`, which those old gems still load.
- `complex_generate` now requests `step` random bytes per loop iteration instead of `size`, matching upstream and avoiding wasted loop iterations caused by indexing past a too-small random buffer.
- Fixed an `O(n^2)` slowdown in the collision test suite (`generated.keys.size` was evaluated eagerly on every iteration instead of the `O(1)` `generated.size`).

## [2.0.0] - 2018-11-07

- Compatibility with original Javascript implementation [NanoID 2.0](https://github.com/ai/nanoid/blob/master/CHANGELOG.md#20).

### Added

- Ability to generate non-secure hashes

### Changed

- Replaced default alphabet character `~` (tilde) with `-` (dash)

## [1.0.0] - 2018-11-06

- Same as 0.2.0, published as compatibility version with original Javascript Nanoid implementation.

## [0.2.0] - 2017-10-27

Compatibility with javascript nanoid 1.0

### Changed

- Calculating mask based on logarithm.
- Default generated ID size changed from 22 to 21.

## [0.1.0] - 2017-09-16

First implementation
