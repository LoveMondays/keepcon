require 'yaml'
require 'faraday'
require 'active_support'
require 'active_support/core_ext/object'

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

    def add_context(params)
      contexts[params[:user].underscore.to_sym] = Context.new(params)
    end
  end
end
