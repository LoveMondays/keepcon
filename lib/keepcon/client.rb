require 'yaml'

module Keepcon
  class Client
    attr_accessor :user, :config
    attr_writer :password

    def initialize
      self.config = YAML.load_file('lib/keepcon/config/urls.yml')
      yield self if block_given?
    end
  end
end
