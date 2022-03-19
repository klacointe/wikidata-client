module Wikidata
  class Config
    class << self
      attr_accessor :options, :faraday, :settings, :mapping

      def configure &block
        yield self
      end
    end

    @options = {}
    @faraday = ->(builder) { builder.adapter :excon }
    @settings = Haschie.new(
      YAML.load_file(
        File.expand_path('../../../config/settings.yml', __FILE__)
      )
    )
    @mapping = Haschie.new(
      YAML.load_file(
        File.expand_path('../../../config/mapping.yml', __FILE__)
      )
    )
  end
end
