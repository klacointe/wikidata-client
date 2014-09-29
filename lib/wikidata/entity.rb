module Wikidata
  class Entity
    extend Forwardable

    attr_accessor :hash
    def_delegators :@hash, :id, :labels, :aliases, :descriptions, :sitelinks

    def initialize hash
      @hash = Hashie::Mash.new hash
      @_properties = {}
    end

    def id
      return hash['id'] if hash['id']
      return hash['title'] if hash['title']
    end

    def title
      return labels['en'].value if labels && labels['en']
      return sitelinks['en'].value if sitelinks && sitelinks['en']
      hash['title'] if hash['title']
    end

    def url
      Wikidata.settings.item.url.gsub(':id', id)
    end

    Wikidata.mapping.resources.each do |k, code|
      define_method k do
        property code
      end
      define_method "#{k}_id" do
        property_id code
      end
    end

    Wikidata.mapping.collections.each do |k, code|
      define_method k do
        properties code
      end
      define_method "#{k}_ids" do
        property_ids code
      end
    end

    def properties code
      @_properties[code] ||= Array(raw_property(code)).map {|a| Wikidata::Property.build a }
    end

    def property_ids code
      Array(raw_property(code)).map do |attribute|
        # TODO Handle other types
        # http://www.wikidata.org/wiki/Wikidata:Glossary#Entities.2C_items.2C_properties_and_queries
        case attribute.mainsnak.datavalue.value['entity-type']
          when 'item'
            prefix = 'Q'
          else
            raise "Unkown wikibase-item entity-type #{attribute.mainsnak.datatype.value['entity-type']}"
        end
        "#{prefix}#{attribute.mainsnak.datavalue.value['numeric-id']}"
      end
    end

    def property code
      properties(code).first
    end

    def property_id code
      property_ids(code).first
    end

    def inspect
      "<#{self.class} id: #{id}, title: \"#{title}\">"
    end

    private

    def raw_property code
      return unless hash.claims
      hash.claims[code]
    end
  end
end
