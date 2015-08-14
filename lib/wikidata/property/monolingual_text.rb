module Wikidata
  module Property
    class MonolingualText < Wikidata::Property::Base
      def text
        value.text
      end

      def language
        value.language
      end
    end
  end
end
