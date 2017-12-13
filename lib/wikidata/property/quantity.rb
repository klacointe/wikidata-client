module Wikidata
  module Property
    class Quantity < Wikidata::Property::Base
      def amount
        value.amount.to_f
      end
      def upperBound
        value.upperBound.to_f
      end
      def lowerBound
        value.lowerBound.to_f
      end
      def unit
        value.unit
      end
    end
  end
end
