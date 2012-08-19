require "incoming/registry"
require "incoming/unknown"
require "incoming/lint"
require "incoming/version"

module Incoming
  def self.receivers
    @registry ||= Registry.new
  end

  def self.receivers= new_registry
    @registry = new_registry
  end
end
