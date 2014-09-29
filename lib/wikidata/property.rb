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
        Wikidata::Item.find Wikidata::Entity.entity_id(attribute)
      else
        raise "Unkown property type #{attribute.mainsnak.datatype}"
      end
    end
  end
end
