module Wikidata
  class Entity < Hashie::Mash
    extend Forwardable

    disable_warnings

    def initialize(hash, opts = {})
      super(hash, opts)
      @_properties = {}
    end

    def id
      self['id'] || self['title']
    end

    def title
      return labels['en'].value if labels && labels['en']
      return sitelinks['en'].value if sitelinks && sitelinks['en']

      title
    end

    def url
      Wikidata.settings.item.url.gsub(':id', id)
    end

    Wikidata.mapping.each do |type, mappings|
      resource = (type.to_sym == :resources)
      mappings.each do |k, code|
        define_method k do
          resource ? property(code) : properties(code)
        end
        define_method(resource ? "#{k}_id" : "#{k}_ids") do
          resource ? property_id(code) : property_ids(code)
        end
      end
    end

    def property_keys
      claims.keys
    end

    def property_name(code)
      Wikidata::Item.find(code).title
    end

    def properties(code)
      @_properties[code] ||= Array(raw_property(code)).map { |a| Wikidata::Property.build a }
    end

    def property_ids(code)
      Array(raw_property(code)).map do |attribute|
        self.class.entity_id attribute
      end.compact
    end

    def property(code)
      properties(code).first
    end

    def property_id(code)
      property_ids(code).first
    end

    def inspect
      "<#{self.class} id: #{id}, title: \"#{title}\">"
    end

    class << self
      # TODO: Handle other types
      # http://www.wikidata.org/wiki/Wikidata:Glossary#Entities.2C_items.2C_properties_and_queries
      def entity_id(attribute)
        return unless attribute.mainsnak.datavalue

        attribute.mainsnak.datavalue.value.tap do |h|
          case h['entity-type']
          when 'item'
            return "Q#{h['numeric-id']}"
          else
            return nil
          end
        end
      end
    end

    private

    def raw_property(code)
      return unless claims

      claims[code]
    end
  end
end
