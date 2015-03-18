require 'keepcon/context'
require 'keepcon/version'

module Keepcon
  class << self
    def setup
      yield self
    end
  end
end
