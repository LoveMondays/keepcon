module Keepcon
  module Integration
    def send_to_keepcon
      keepcon_entity.send_data
    end

    def keepcon_entity
      @keepcon_entity ||= Entity.new(context: keepcon_context, instance: self)
    end

    def keepcon_context
      self.class.keepcon_context
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      mattr_accessor :keepcon_context

      def keepcon_integration(context, mappings = {})
        fail 'The context does not exist' unless find_context(context)
        keepcon_context.map(mappings)
      end

      private

      def find_context(context)
        self.keepcon_context = Keepcon.contexts[context]
      end
    end
  end
end
