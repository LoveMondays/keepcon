require 'gyoku'
require 'action_view'

module Keepcon
  class Entity
    include ActionView::Helpers::TagHelper

    attr_accessor :context, :instance

    def initialize(params = {})
      params.each { |k, v| send("#{k}=", v) }
    end

    def translate
      context.attribute_names.map do |attr_name|
        [context.translate(attr_name), instance.send(attr_name)]
      end.to_h
    end

    def to_xml
      Gyoku.xml(xml_hash)
    end

    private

    def xml_hash
      {
        import: {
          contenttype: context.name,
          contents: {
            content: [
              { :@id => instance.id }.merge(translate_to_xml_hash)
            ]
          }
        }
      }
    end

    def translate_to_xml_hash
      translate.map { |k, v| ["#{k}!", { content!: cdata_section(v) }] }.to_h
    end
  end
end
