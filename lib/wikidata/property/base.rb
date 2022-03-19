require 'wikidata/property/hash'

module Wikidata
  module Property
    class Base
      attr_reader :property

      def initialize(property)
        @property = Wikidata::Property::Hash.new(property)
      end

      def value
        property.mainsnak.datavalue.value
      end
    end
  end
end
