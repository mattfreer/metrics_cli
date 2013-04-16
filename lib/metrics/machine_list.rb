require 'forwardable'

module Metrics
  class MachineList
    include Enumerable
    extend Forwardable

    def_delegators :@machines, :size, :each, :last, :first
    attr_reader :machines

    def initialize(data)
      @data = data
      create_machines
    end

    def metrics
      Metrics::MetricsList.new(raw_metrics_data)
    end

    private
    def raw_metrics_data
      @machines.map &:data
    end

    def create_machines
      @machines = @data.map { |d| Machine.new(:id => d.first, :url => d.last) }
    end
  end
end
