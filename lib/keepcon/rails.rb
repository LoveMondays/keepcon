module Keepcon
  class Rails
    class << self
      def setup!
        add_integration(ActiveModel::Model) if defined?(ActiveModel::Model)
      end

      private

      def add_integration(klass)
        klass.include(Integration) unless klass.include?(Integration)
      end
    end
  end
end
