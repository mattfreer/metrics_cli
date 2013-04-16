require 'virtus'
require 'dm-validations'
require "net/http"
require "uri"
require "ipaddress"
require 'json'

module Metrics
  class Machine
    include Methadone::CLILogging
    include Virtus
    include DataMapper::Validations

    attribute :id, String

    attribute :url, String

    attribute :data, Hash,
      :default => lambda { |machine, attribute| machine.send(:fetch_data)},
      :writer => :private

    attribute :metrics, Hash,
      :default => lambda { |machine, attribute| machine.send(:read_metrics)},
      :writer => :private

    private

    def read_metrics
      data["metrics"]
    end

    def fetch_data
      uri = URI.parse(url)
      JSON.parse(Net::HTTP.get(uri))
    end
  end
end
