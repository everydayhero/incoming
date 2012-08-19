require 'test_helper'

module Incoming
  class UnknownTest < MiniTest::Unit::TestCase
    include Lint::Tests

    def test_receive_is_false
      refute model.receive
    end

    def model
      Unknown.new
    end
  end
end
