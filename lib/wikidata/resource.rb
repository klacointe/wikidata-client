module Wikidata
  class Resource
    attr_accessor :item
    delegate :claims_for_property_id, to: :item

    def initialize item
      return unless item.data_hash
      @item = item
    end

    def name
      return @_name if @_name
      %w{fr en}.each do |l|
        @_name ||= item.labels[l].value if item.data_hash[:labels] && item.labels[l]
        @_name ||= item.sitelinks["#{l}wiki"].title if item.data_hash[:sitelinks] && item.sitelinks["#{l}wiki"]
      end
      @_name
    end

    def url
      Gaston.wikidata.item_url.gsub(':id', item.id)
    end

    Gaston.wikidata.accessors.each do |k|
      define_method k do
        item.data_hash[k]
      end
    end

    Gaston.wikidata.mapping.resources.each do |k, code|
      define_method k do
        property code
      end
      define_method "#{k}_id" do
        property_id code
      end
    end
    Gaston.wikidata.mapping.collections.each do |k, code|
      define_method k do
        properties code
      end
      define_method "#{k}_ids" do
        property_ids code
      end
    end

    def properties code
      claims_for_property_id(code).map {|a| Wikidata::Attribute.build a }
    end

    def property code
      properties(code).first
    end

    def property_ids code
      claims_for_property_id(code).map do |a|
        begin
          "Q#{a.mainsnak.value.data_hash['numeric-id']}"
        rescue
          nil
        end
      end.compact
    end

    def property_id code
      property_ids(code).first
    end
  end
end
