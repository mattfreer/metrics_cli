require 'virtus'
require 'dm-validations'
require "net/http"
require "uri"
require "ipaddress"
require 'json'
require 'enumerable'
require 'methadone'
require 'validators'

module Metrics
  class Cluster
    include Validators::UrlOrIpValidator
    include Methadone::CLILogging
    include Virtus
    include DataMapper::Validations

    attribute :url, String

    attribute :data, Hash,
      :default => lambda { |cluster, attribute| cluster.send(:fetch_data)},
      :writer => :private

    attribute :machines, Array,
      :default => lambda { |cluster, attribute| cluster.send(:create_machines)},
      :writer => :private

    attribute :metrics_summary, Array,
      :default => lambda { |cluster, attribute| cluster.send(:read_metrics_summary)},
      :writer => :private

    validates_url_or_ip :url #custom validator

    private

    def fetch_data
      uri = URI.parse(url)
      JSON.parse(Net::HTTP.get(uri))
    end

    def create_machines
      Metrics::MachineList.new(data)
    end

    def read_metrics_summary
      machines.metrics.summary
    end
  end
end
