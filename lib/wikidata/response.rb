module Wikidata
  class Response
    extend Forwardable

    def_delegators :results, :size

    def initialize raw
      @raw = raw
    end

    def results
      return [] if empty?
      @_results ||= raw_results.map{|r| Wikidata::Item.new(r) }
    end

    def empty?
      @_empty ||= (@raw.body['entities'].nil? ||
                   @raw.body['entities'].is_a?(Array) && @raw.body['entities'].empty?)
    end

    def inspect
      "<#{self.class} results: #{results.inspect}>"
    end

    protected

    def raw_results
      return [] if empty?
      @raw.body['entities'].values.reject{|r| r['missing'] }
    end
  end
end
