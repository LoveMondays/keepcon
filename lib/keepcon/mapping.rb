module Keepcon
  class Mapping
    attr_accessor :from, :to

    def initialize(params = {})
      params.each { |k, v| send("#{k}=", v) }
    end
  end
end
