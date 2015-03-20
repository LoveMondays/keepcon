module Keepcon
  class Client
    attr_accessor :user, :config
    attr_writer :password

    def initialize
      self.config = {}
      config['urls'] = YAML.load_file(urls_config_path)
      config['client'] = YAML.load_file(client_config_path)
      yield self if block_given?
    end

    def content_request(data)
      fail ArgumentError, 'The data can not be empty' unless data.present?

      request(:put, config['urls']['content']['sync'], data)
    end

    private

    def request(method, path, data)
      connection.send(method, path, data.to_s, headers)
    end

    def connection
      Faraday.new(url: config['urls']['keepcon']['sync']).tap do |c|
        c.basic_auth(user, @password)
      end
    end

    def urls_config_path
      File.expand_path('../config/urls.yml', __FILE__)
    end

    def client_config_path
      File.expand_path('../config/client.yml', __FILE__)
    end

    def headers
      { 'User-Agent' => user_agent }
    end

    def user_agent
      config['client']['request']['headers']['user_agent'] % { user: user }
    end
  end
end
