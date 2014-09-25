module Wikidata
  class Item < Entity
    DEFAULT_QUERIES = {
      search: {
        action: 'query',
        list: 'search'
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
        build_from_results Wikidata::Client.new( q ).results, ids.is_a?(Array)
      end

      def find_by_title titles, query = {}
        q = DEFAULT_QUERIES[:find]
              .merge( query )
              .merge( titles: Array(titles).join('|') )
        build_from_results Wikidata::Client.new( q ).results, titles.is_a?(Array)
      end

      def search search, query = {}
        q = DEFAULT_QUERIES[:search].merge( srsearch: search ).merge(query)
        find Wikidata::Client.new( q ).results.map{|r| r['title']}
      end

      def build_from_results results, multiple = true
        results.map{|r| new(r) }.tap do |items|
          return items.first unless multiple
        end
      end
    end
  end
end
