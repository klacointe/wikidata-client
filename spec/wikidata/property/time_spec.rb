require 'spec_helper'

describe Wikidata::Property::Time do
  let(:joconde) { Wikidata::Item.find_by_title 'Mona Lisa' }
  let(:range_of_year) {
    described_class.new(
      {
        "id" => "Q12418$8EDF7B01-3F71-4DA7-8B52-8C26242F0293",
        "mainsnak" => {
          "snaktype" => "value",
            "property" => "P571",
            "datatype" => "time",
            "datavalue"=> {
              "value" => {
                "time" => "+00000001503-01-01T00:00:00Z",
                "timezone" => 0,
                "before" => 0,
                "after" => 3,
                "precision" => 9,
                "calendarmodel" => "http://www.wikidata.org/entity/Q1985727"
              },
              "type" => "time"
            }
        },
       "type" => "statement",
       "rank" => "normal",
       "references" => [
         {
           "hash" => "592714cb87c0fc64425e45a185765982f444e5ad",
           "snaks" => {
             "P143" => [
               {
                 "snaktype" => "value",
                 "property" => "P143",
                 "datatype" => "wikibase-item",
                 "datavalue"=> {
                   "value" => {
                     "entity-type" => "item",
                     "numeric-id" => 465
                   },
                   "type" => "wikibase-entityid"
                 }
               }
             ]
           },
           "snaks-order" => ["P143"]
         }
       ]
      }
    )
  }

  it 'should return Time from a a key (date_of_foundation_or_creation here)' do
    range_of_year.tap do |date|
      date.should be_kind_of Wikidata::Property::Time
      date.date.should eq DateTime.new(1503, 1, 1)
      date.range.min.should eq DateTime.new(1503, 1, 1, 0, 0, 0)
      date.range.max.should eq DateTime.new(1505, 12, 31, 00, 00, 00)
    end
  end
end
