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
        context = find_context(context_name)
        context.map(mappings)

        define_method("send_#{context_name}_to_keepcon") do |mode = :sync|
          send_to_keepcon(context, mode)
        end
      end

      def fetch_keepcon_results(context_name)
        context = find_context(context_name)

        results = context.client.async_results_request
        response = Entity::Response.new(results)
        context.client.async_ack(response.data['setId'])

        response
      end

      private

      def find_context(context)
        Keepcon.contexts[context] ||
          fail("The context=#{context} does not exist")
      end
    end
  end
end
