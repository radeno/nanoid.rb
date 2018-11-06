require 'benchmark/ips'
require_relative '../lib/nanoid'

Benchmark.ips do |x|
  # Configure the number of seconds used during
  # the warmup phase (default 2) and calculation phase (default 5)
  x.config(time: 5, warmup: 2)

  x.report("secure") do
    Nanoid.generate
  end

  x.report("non-secure") do |times|
    Nanoid.generate(non_secure: true)
  end

  x.compare!
end
