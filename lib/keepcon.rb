require 'active_support'
require 'active_support/core_ext/object'

require 'keepcon/client'
require 'keepcon/context'
require 'keepcon/entity'
require 'keepcon/mapping'
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
