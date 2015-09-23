module Keepcon
  class Client
    attr_accessor :user, :config
    attr_writer :password

    def initialize
      self.config = {
        'urls' => load_yml('config/urls.yml'),
        'client' => load_yml('config/client.yml')
      }

      yield self if block_given?
    end

    def content_request(data, mode)
      fail ArgumentError, 'The data can not be empty' unless data.present?

      request(:put, config['urls']['content']['request'][mode.to_s], data, mode)
    end

    def async_results_request
      url = config['urls']['content']['response']['async']
      url = url % { context_name: user }

      request(:put, url)
    end

    def async_ack(setId)
      url = config['urls']['content']['response']['ack']
      url = url % { setId: setId }

      request(:put, url)
    end

    private

    def request(method, path, data = '', mode = :async)
      connection(mode).send(method, path, data.to_s, headers)
    end

    def connection(mode)
      Faraday.new(url: config['urls']['keepcon'][mode.to_s]).tap do |c|
        c.basic_auth(user, @password)
      end
    end

    def load_yml(file)
      path = File.expand_path("../#{file}", __FILE__)
      YAML.load_file(path)
    end

    def headers
      {
        'User-Agent' => user_agent,
        'Content-Type' => 'text/plain; charset=utf-8'
      }
    end

    def user_agent
      config['client']['request']['headers']['user_agent'] % { user: user }
    end
  end
end
