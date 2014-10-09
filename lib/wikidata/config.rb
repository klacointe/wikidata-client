module Wikidata
  class Config
    class << self
      attr_accessor :faraday, :settings, :mapping

      def configure &block
        yield self
      end
    end

    @faraday = -> (builder) { builder.adapter :excon }
    @settings = Hashie::Mash.new(
      YAML.load_file(
        File.expand_path('../../../config/settings.yml', __FILE__)
      )
    )
    @mapping = Hashie::Mash.new(
      YAML.load_file(
        File.expand_path('../../../config/mapping.yml', __FILE__)
      )
    )
  end
end
