require 'benchmark'
require File.expand_path("../benchmark_helper.rb", __FILE__)
include BenchmarkHelper

ensure_database

def benchmark_rails_console
  Benchmark.realtime do
    success = system("echo 'Listing.all == [] ? exit(0) : exit(1)' | #{ENV['RUBY_COMMAND']} script/rails c")

    raise "Rails startup failed!" unless success
  end
end

STDERR.puts "warmup..."
STDERR.puts "#{benchmark_rails_console} seconds"

runs = 3

durations = (1..runs).map do
  benchmark_rails_console
end

duration = durations.inject(0.0) { |sum, t| sum + t } / runs

puts "#{duration} seconds"