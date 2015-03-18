module Keepcon
  class Context
    attr_accessor :name
    attr_writer :password

    def initialize(params = {})
      @mappings = {}
      params.each { |k, v| send("#{k}=", v) }
    end

    def map(hash)
      hash.each { |k, v| add_mapping(k, v) }
    end

    def translate(attribute)
      @mappings[attribute].try(:to)
    end

    private

    def add_mapping(from, to)
      mapping = Mapping.new(from: from, to: to)
      @mappings[mapping.from] = mapping
    end
  end
end
