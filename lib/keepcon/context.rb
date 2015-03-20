module Keepcon
  class Context
    attr_accessor :name
    attr_writer :password

    def initialize(params = {})
      @mappings = {}
      map(params[:mappings])
      params.except(:mappings).each { |k, v| send("#{k}=", v) }
    end

    def map(hash)
      return unless hash.present?
      hash.each { |k, v| add_mapping(k, v) }
    end

    def translate(attribute)
      @mappings[attribute].try(:to)
    end

    def attribute_names
      @mappings.keys
    end

    private

    def add_mapping(from, to)
      mapping = Mapping.new(from: from, to: to)
      @mappings[mapping.from] = mapping
    end
  end
end
