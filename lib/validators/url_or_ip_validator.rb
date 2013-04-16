module Validators
  module UrlOrIpValidator
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      attr_reader :url_attribute

      def validates_url_or_ip(attribute)
        @url_attribute = attribute
        validates_with_method attribute, :valid_url_or_ip?
      end
    end

    private
    def attribute_value
      self.send(self.class.url_attribute)
    end

    def valid_url_or_ip?
      unless valid_url? || IPAddress.valid?(attribute_value)
        [ false, "Not an URL or IP address"]
      else
        true
      end
    end

    def valid_url?
      begin
        uri = URI.parse(attribute_value)
        uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
      rescue URI::BadURIError => e
        false
      end
    end
  end
end
