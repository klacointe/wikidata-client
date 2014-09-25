module Wikidata
  module Property
    def self.build attribute
      return if attribute.mainsnak.snaktype == "somevalue"
      case attribute.mainsnak.datatype
      when 'string'
        Wikidata::Property::String.new attribute
      when 'time'
        Wikidata::Property::Time.new attribute
      when 'globe-coordinate'
        Wikidata::Property::GlobeCoordinate.new attribute
      when 'url'
        Wikidata::Property::Url.new attribute
      when 'wikibase-item'
        # TODO Handle other types
        # http://www.wikidata.org/wiki/Wikidata:Glossary#Entities.2C_items.2C_properties_and_queries
        case attribute.mainsnak.datavalue.value['entity-type']
          when 'item'
            prefix = 'Q'
          else
            raise "Unkown wikibase-item entity-type #{attribute.mainsnak.datatype.value['entity-type']}"
        end
        Wikidata::Item.find "#{prefix}#{attribute.mainsnak.datavalue.value['numeric-id']}"
      else
        raise "Unkown property type #{attribute.mainsnak.datatype}"
      end
    end
  end
end
