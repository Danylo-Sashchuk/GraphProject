# frozen_string_literal: true

class GraphException < StandardError
  attr_reader :underlying_exception

  def initialize(msg = 'GraphException occurred.', exception = nil)
    super(msg)
    @underlying_exception = exception
  end

  def message_with_details
    msg = "GraphException occurred:\n"
    if underlying_exception
      msg += "  Class: #{underlying_exception.class.name}\n"
      msg += "  Message: #{underlying_exception.message}\n"
      msg += "  Backtrace:\n#{underlying_exception.backtrace.join("\n")}\n"
    else
      msg += "  No underlying exception details available.\n"
    end
    msg
  end
end
