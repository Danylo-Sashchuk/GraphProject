# frozen_string_literal: true

class Util
  def self.arrays_equal_disregard_order(array_a, array_b)
    ((array_a.to_a - array_b.to_a) + (array_b.to_a - array_a.to_a)).empty?
  end

  def self.arrays_of_arrays_equal_disregard_order(array_of_array_a, array_of_array_b)
    return false unless array_of_array_a.length == array_of_array_b.length

    array_of_array_a.all? do |inner_array_a|
      array_of_array_b.any? do |inner_array_b|
        arrays_equal_disregard_order(inner_array_a, inner_array_b)
      end
    end
  end
end
