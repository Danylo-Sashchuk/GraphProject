# frozen_string_literal: true

class Util
  def self.arrays_equal_disregard_order(array_a, array_b)
    ((array_a - array_b) + (array_b - array_a)).empty?
  end
end
