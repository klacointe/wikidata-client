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
        _find :ids, ids, query
      end

      def find_by_title titles, query = {}
        _find :titles, titles, query
      end

      def _find finder = :ids, list = '', query = {}
        q = DEFAULT_QUERIES[:find]
              .merge( query )
              .merge( finder => Array(list).join('|') )
        Wikidata::Client.new( q ).response.tap do |resp|
          return resp.results.first unless list.is_a?(Array)
        end
      end

      def search search, query = {}
        q = DEFAULT_QUERIES[:search].merge( srsearch: search ).merge(query)
        Wikidata::Client.new( q ).response
      end
    end
  end
end
