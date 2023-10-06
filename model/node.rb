# frozen_string_literal: true

class Node
  attr_reader :name

  def initialize(name)
    raise TypeError, "Node name must be symbol, but received #{name.class}" unless name.is_a?(Symbol)

    @name = name
  end

  def to_s
    @name.name
  end

  def ==(other)
    @name == other.name
  end

  def hash
    @name.to_s.hash
  end

  def eql?(other)
    other.is_a?(Node) && self == other
  end
end
