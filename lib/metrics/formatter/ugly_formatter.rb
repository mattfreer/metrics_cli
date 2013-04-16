require 'formatador'

module Metrics
  module Formatter
    class UglyFormatter
      def show(metrics)
        metrics.each do |metric|
          puts("")
          display_metric(metric)
        end
      end

      private
      def display_metric(metric)
        metric.each do |key, value|
          Formatador.display_line("[green]#{ key }[/]: #{ value }")
        end
      end
    end
  end
end
