require 'formatador'

module Metrics
  module Formatter
    class PrettyFormatter
      def show(metrics)
        keys = metrics.first.keys
        Formatador.display_table(metrics, keys)
      end
    end
  end
end
