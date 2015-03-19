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
      translation = context.attribute_names.map do |attr_name|
        [context.translate(attr_name), instance.send(attr_name)]
      end
      Hash[translation]
    end

    def to_xml
      Gyoku.xml(xml_hash)
    end

    private

    def xml_hash
      {
        import: {
          contenttype: context.user,
          contents: {
            content: [
              { :@id => instance.id }.merge(translate_to_xml_hash)
            ]
          }
        }
      }
    end

    def translate_to_xml_hash
      translation = translate.map do |k, v|
        case k
        when :datetime then [k, { content!: (v.to_f * 1_000).to_i }]
        when :author then [k, { :@type => :author, :content! => v }]
        else ["#{k}!", { content!: cdata_section(v) }]
        end
      end
      Hash[translation]
    end
  end
end
