module Keepcon
  class Entity
    class Response
      attr_accessor :status, :body

      def initialize(http_response)
        self.body = http_response.body
        self.status = http_response.status
      end
    end
  end
end
