module Wikidata
  module Property
    class Quantity < Wikidata::Property::Base
      def amount
        value.amount
      end
      def upperBound
        value.upperBound
      end
      def lowerBound
        value.lowerBound
      end
      def unit
        value.unit
      end
    end
  end
end
