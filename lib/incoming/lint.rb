module Incoming
  module Lint
    module Tests
      def test_accepted_attributes
        assert model.respond_to?(:accepted_attributes), "The model needs to respond to #accepted_attributes"
      end

      def test_receive
        assert model.respond_to?(:receive), "The model needs to respond to #receive"
      end
    end
  end
end
