module Wikidata
  class Config
    class << self
      attr_accessor :options, :adapter, :settings, :mapping

      def configure
        yield self
      end
    end

    @options = {}
    @adapter = :excon
    @settings = Hashie::Mash.new(
      YAML.load_file(
        File.expand_path('../../config/settings.yml', __dir__)
      )
    )
    @mapping = Hashie::Mash.new(
      YAML.load_file(
        File.expand_path('../../config/mapping.yml', __dir__)
      )
    )
  end
end
