module Wikidata
  class Client
    DEFAULT_QUERY = {
      format: 'json'
    }

    attr_accessor :query, :total_pages

    def initialize query = {}
      @query = DEFAULT_QUERY.merge(query)
    end

    def results
      return @_results if @_results
      call
      @_results = case @query[:action]
      when 'query'
        search_results
      when 'wbgetentities'
        entities_results
      else
        raise "Unhandle query: #{@query['action']}"
      end
    end

    private

    def call
      response = api.get '', query
      handle_error response
      @response = response
    end

    def entities_results
      @response.body['entities'].values
    end

    def search_results
      @response.body['query']['search']
    end

    def handle_error response
      raise RequestError unless response.success?
      return unless response.body['error']
      response.body['error'].tap do |error|
        case error['code']
          when 'no-such-entity'
            raise ItemNotFound.new error
          else
            raise UnknownError.new error
        end
      end
    end

    def api
      Faraday.new({url: Wikidata.settings.api.url}.merge(Wikidata.client_options)) do |faraday|
        faraday.request  :url_encoded
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter  :patron
      end
    end
  end

  class ClientException < Exception; end
  class RequestError < ClientException;
    def initialize error
      @error = error
    end

    def message
      super unless @error
    end
  end
  class UnknownError < ClientException; end
  class ItemNotFound < ClientException; end
end
