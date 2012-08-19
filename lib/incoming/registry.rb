module Incoming
  class Registry
    def initialize
      @receivers = {}
    end

    def register receiver
      @receivers[receiver.name] = receiver
    end

    def registered? receiver
      @receivers[receiver.name]
    end

    def for payload
      handler_for(payload).new payload[payload.keys.first]
    end

    def handler_for payload
      @receivers.fetch(payload.keys.first) { Unknown }
    end
  end
end
