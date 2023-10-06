# frozen_string_literal: true
require 'set'

a = Set.new([:a, :b])
b = Set.new([:b, :a])

puts a == b