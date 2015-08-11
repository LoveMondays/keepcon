module Keepcon
  module Integration
    def send_to_keepcon(context, mode)
      keepcon_entity(context).send_data(mode)
    end

    def keepcon_entity(context)
      Entity.new(context: context, instance: self)
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def keepcon_integration(context_name, mappings = {})
        unless (context = find_context(context_name))
          fail 'The context does not exist'
        end

        context.map(mappings)

        define_method("send_#{context_name}_to_keepcon") do |mode = :sync|
          send_to_keepcon(context, mode)
        end
      end

      private

      def find_context(context)
        Keepcon.contexts[context]
      end
    end
  end
end
