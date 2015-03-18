module Keepcon
  class Context
    attr_accessor :name, :password

    def initialize(params)
      params.each { |k, v| send("#{k}=", v) }
    end
  end
end
