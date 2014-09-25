module Wikidata
  module Property
    class GlobeCoordinate < Wikidata::Property::Base
      def latitude
        value.latitude
      end

      def longitude
        value.longitude
      end
    end
  end
end
