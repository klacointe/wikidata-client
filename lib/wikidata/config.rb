module Wikidata
  class Config
    class << self
      attr_accessor :client_options, :settings

      def configure &block
        yield self
      end
    end

    @client_options = {}
    @settings = Hashie::Mash.new(
      YAML.load_file(
        File.expand_path('../../../config/wikidata.yml', __FILE__)
      )
    )
  end
end
