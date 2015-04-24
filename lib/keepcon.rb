require 'yaml'
require 'faraday'
require 'active_support'
require 'active_support/core_ext/object'
require 'active_support/core_ext/time'

require 'keepcon/client'
require 'keepcon/context'
require 'keepcon/entity'
require 'keepcon/integration'
require 'keepcon/mapping'
require 'keepcon/rails'
require 'keepcon/version'

module Keepcon
  mattr_accessor :contexts
  self.contexts = {}

  Rails.setup!

  class << self
    def setup
      yield self
    end

    def add_context(name, params)
      contexts[name] = Context.new(params)
    end
  end
end
