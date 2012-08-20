module Incoming
  class Registry
    def initialize
      @receivers = {}
    end

    def register receiver
      @receivers[receiver.payload_key] = receiver
    end

    def registered? receiver
      @receivers[receiver.payload_key]
    end

    def for payload
      handler_for(payload).new payload[payload.keys.first]
    end

    def handler_for payload
      @receivers.fetch(payload.keys.first) { Unknown }
    end
  end
end
