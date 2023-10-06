# frozen_string_literal: true

require 'minitest/autorun'

Dir.glob(File.expand_path('*.rb', __dir__)).sort.each { |file| require file }

Minitest.run

