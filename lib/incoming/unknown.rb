module Incoming
  class Unknown
    def initialize attributes = nil
    end

    def accepted_attributes
      []
    end

    def receive
      false
    end
  end
end
