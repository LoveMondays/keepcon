module Keepcon
  class Entity
    attr_accessor :context, :instance

    def initialize(params = {})
      params.each { |k, v| send("#{k}=", v) }
    end

    def translate
      context.attribute_names.map do |attr_name|
        [context.translate(attr_name), instance.send(attr_name)]
      end.to_h
    end
  end
end
