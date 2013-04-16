require 'forwardable'

module Metrics
  class MetricsList
    include Enumerable
    extend Forwardable

    def_delegators :@metrics, :size, :each, :last, :first
    attr_reader :metrics
    attr_reader :summary

    def initialize(data)
      @data = data
      @metrics = read_metrics
      @summary = create_summary
    end

    def index_of_minimum(metric)
      values = values_by_metric(metric)
      values.rindex(values.min)
    end

    def index_of_maximum(metric)
      values = values_by_metric(metric)
      values.rindex(values.max)
    end

    def metric_keys
      @metrics.flat_map(&:keys)
    end

    def uniq_metric_keys
      metric_keys.uniq
    end

    def key_count
      key_count = Hash.new(0)
      metric_keys.each { |key| key_count[key] += 1 }
      key_count
    end

    def values_by_metric(metric)
      @metrics.map { |hash| hash.select { |key, value| metric == key }}.map { |h| h[metric]}
    end

    def standard_deviation_for_metric(metric)
      values_by_metric(metric).standard_deviation.round(2)
    end

    private
    def create_summary
      a = []
      uniq_metric_keys.each do |m|
        a << {
          :METRIC => m,
          :NUM => key_count[m],
          :MINIMUM => machine_id_by_index(index_of_minimum(m)),
          :MAXIMUM => machine_id_by_index(index_of_maximum(m)),
          :STD => standard_deviation_for_metric(m)
        }
      end
      a
    end

    def read_metrics
      @data.map { |h| h["metrics"] }
    end

    def machine_id_by_index(id)
      @data[id]["id"]
    end
  end
end
