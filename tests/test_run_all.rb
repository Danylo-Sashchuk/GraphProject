# frozen_string_literal: true

require 'minitest/autorun'

Dir.glob(File.join(File.dirname(__FILE__), 'test_*.rb')).sort.each do |test_file|
  require_relative test_file
end

# Load all test files in the 'graph_tests' subdirectory
graph_tests_dir = File.join(File.dirname(__FILE__), 'graph_tests')
Dir.glob(File.join(graph_tests_dir, 'test_*.rb')).sort.each do |test_file|
  require_relative test_file
end

Minitest.run

