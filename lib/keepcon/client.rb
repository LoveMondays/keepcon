module Keepcon
  class Client
    attr_accessor :user, :config
    attr_writer :password

    def initialize
      self.config = {}
      config['urls'] = YAML.load_file('lib/keepcon/config/urls.yml')
      config['client'] = YAML.load_file('lib/keepcon/config/client.yml')
      yield self if block_given?
    end

    def send(data)
      fail ArgumentError, 'The data can not be empty' unless data.present?

      conn = Faraday.new(url: config['urls']['keepcon']['sync'])
      conn.put(config['urls']['content']['sync'], data.to_s, headers)
    end

    private

    def headers
      { 'User-Agent' => user_agent }
    end

    def user_agent
      config['client']['request']['headers']['user_agent'] % { user: user }
    end
  end
end
