module Wikidata
  class SearchResponse < Response

    def results
      return [] if empty?
      @_results ||= Wikidata::Item.find(raw_ids).results
    end

    def empty?
      @_empty ||= @raw.body['query'].nil?
    end

    def total_hits
      return if empty?
      @raw.body['query']['searchinfo']['totalhits']
    end

    def next_page_offset
      return if empty?
      @raw.body['query-continue']['search']['sroffset']
    end

    protected

    def raw_ids
      return if empty?
      @raw.body['query']['search'].map{|r| r['title'] }
    end

    def raw_results
      return [] if empty?
      @raw.body['query']['search']
    end
  end
end
