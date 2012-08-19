require 'test_helper'

module Incoming
  class RegistryTest < MiniTest::Unit::TestCase
    def test_registed_is_true_with_a_registered_receiver
      receiver = OpenStruct.new :name => 'receiver'
      registry = Registry.new
      registry.register receiver

      assert registry.registered?(receiver)
    end

    def test_registed_is_false_with_an_unregistered_receiver
      registry = Registry.new

      refute registry.registered?(OpenStruct.new)
    end

    def test_handler_for_returns_unknown
      registry = Registry.new

      assert_equal Unknown, registry.handler_for({})
    end

    def test_handler_for_returns_receiver
      klass = Class.new do
        def self.name
          'receiver'
        end
      end

      registry = Registry.new
      registry.register klass

      assert_equal klass, registry.handler_for({'receiver' => {}})
    end

    def test_for_initializes_klass
      klass = Class.new do
        def self.name
          'receiver'
        end

        attr_accessor :name

        def initialize attributes = nil
          attributes ||= {}

          attributes.each do |attr, value|
            send "#{attr}=", value
          end
        end
      end

      payload = {
        'receiver' => {
          'name' => 'tim'
        }
      }
      registry = Registry.new
      registry.register klass
      receiver = registry.for payload

      assert_equal 'tim', receiver.name
    end
  end
end
