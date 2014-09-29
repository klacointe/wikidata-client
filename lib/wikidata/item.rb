module Wikidata
  class Item < Entity
    DEFAULT_QUERIES = {
      search: {
        action: 'query',
        list: 'search',
        sroffset: 0,
        srlimit: 10
      },
      find: {
        action: 'wbgetentities',
        sites: 'enwiki'
      }
    }.freeze

    class << self
      def find ids, query = {}
        q = DEFAULT_QUERIES[:find]
              .merge( query )
              .merge( ids: Array(ids).join('|') )
        Wikidata::Client.new( q ).response.tap do |resp|
          return resp.results.first unless ids.is_a?(Array)
        end
      end

      def find_by_title titles, query = {}
        q = DEFAULT_QUERIES[:find]
              .merge( query )
              .merge( titles: Array(titles).join('|') )
        Wikidata::Client.new( q ).response.tap do |resp|
          return resp.results.first unless titles.is_a?(Array)
        end
      end

      def search search, query = {}
        q = DEFAULT_QUERIES[:search].merge( srsearch: search ).merge(query)
        Wikidata::Client.new( q ).response
      end
    end
  end
end
