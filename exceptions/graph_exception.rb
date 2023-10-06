# frozen_string_literal: true

class GraphException < StandardError
  def initialize(e)
    super("GraphException occurred: #{e.class}: #{e.message}\n#{e.backtrace.join("\n")}")
  end
end
