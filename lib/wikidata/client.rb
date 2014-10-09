module Wikidata
  class Client
    DEFAULT_QUERY = {
      format: 'json'
    }

    attr_accessor :query, :total_pages

    def initialize query = {}
      @query = DEFAULT_QUERY.merge(query)
    end

    def response
      response_class.new api.get('', query)
    end

    private

    def response_class
      case @query[:action]
      when 'query'
        Wikidata::SearchResponse
      else
        Wikidata::Response
      end
    end

    def api
      Faraday.new(url: Wikidata.settings.api.url) do |faraday|
        faraday.request  :url_encoded
        faraday.response :json, content_type: /\bjson$/
        Wikidata.faraday.call faraday
      end
    end
  end
end
