module Wikidata
  module Property

    class Base
      attr_reader :property

      def initialize property
        @property = Hashie::Mash.new(property)
      end

      def value
        property.mainsnak.datavalue.value
      end
    end
  end
end
