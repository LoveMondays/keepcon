require 'active_support'

require 'keepcon/context'
require 'keepcon/version'

module Keepcon
  mattr_accessor :contexts
  self.contexts = []

  class << self
    def setup
      yield self
    end

    def add_context(params)
      contexts << Context.new(params)
    end
  end
end
