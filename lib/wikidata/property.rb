module Wikidata
  module Property
    def self.build attribute
      return if %w{somevalue novalue}.include? attribute.mainsnak.snaktype
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
      when 'commonsMedia'
        Wikidata::Property::CommonsMedia.new attribute
      when 'monolingualtext'
        Wikidata::Property::MonolingualText.new attribute
      else
        puts "Unkown property type #{attribute.mainsnak.datatype}"
      end
    end
  end
end
