module Keepcon
  class Rails
    class << self
      def setup!
        add_integration(ActiveRecord::Base) if defined?(ActiveRecord::Base)
      end

      private

      def add_integration(klass)
        klass.send(:include, Integration) unless klass.include?(Integration)
      end
    end
  end
end
