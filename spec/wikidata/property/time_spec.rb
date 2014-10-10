require 'spec_helper'

describe Wikidata::Property::Time do
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

  let(:bc_date) {
    described_class.new(
      {
        "id" => "Q7463501$d6247f70-4dcf-afcd-81af-6e20f0d85c3a",
        "mainsnak" => {
          "snaktype" => "value",
          "property" => "P580",
          "datatype" => "time",
          "datavalue" =>  {
            "value" =>  {
              "time" => "-00002500000-01-01T00:00:00Z",
              "timezone" => 0,
              "before" => 0,
              "after" => 0,
              "precision" => 4,
              "calendarmodel" => "http://www.wikidata.org/entity/Q1985727"
            },
            "type" => "time"
          }
        },
        "qualifiers" => {
          "P518" => [
            {
              "hash" => "34768c4845167709a7bcf6a10da46bf1bd0b7232",
              "snaktype" => "value",
              "property" => "P518",
              "datatype" => "wikibase-item",
              "datavalue" =>  {
                "value" =>  {
                  "entity-type" => "item",
                  "numeric-id" => 15
                },
                "type" => "wikibase-entityid"
              }
            }
          ]
        },
        "qualifiers-order" => ["P518"],
        "type" => "statement",
        "rank" => "normal"
      }
    )
  }

  it 'should return a range of DateTime' do
    range_of_year.tap do |date|
      date.should be_kind_of Wikidata::Property::Time
      date.date.should eq DateTime.new(1503, 1, 1)
      date.range.min.should eq DateTime.new(1503, 1, 1, 0, 0, 0)
      date.range.max.should eq DateTime.new(1505, 12, 31, 00, 00, 00)
    end
  end

  it 'should handle BC dates' do
    bc_date.date.should eq DateTime.new(-2500000, 1, 1, 0, 0, 0)
  end
end
