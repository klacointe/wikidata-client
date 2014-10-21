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

  let(:century) {
    described_class.new(
      {
        "id" => "Q7061$34CD4AAF-6C99-47CF-AE0E-1E0941C90F1E",
        "mainsnak" => {
          "snaktype" => "value",
          "property" => "P585",
          "datatype" => "time",
          "datavalue" => {
            "value" => {
              "time" => "+00000001200-01-01T00:00:00Z",
              "timezone" => 0,
              "before" => 0,
              "after" => 0,
              "precision" => 7,
              "calendarmodel" => "http://www.wikidata.org/entity/Q1985727"
            },
            "type" => "time"
          }
        },
        "type"=>"statement",
        "rank"=>"normal"
      }
    )
  }

  let(:century_bc) {
    described_class.new(
      {
        "id" => "Q171812$DEB83BAE-F6E0-48D4-B45B-7E15B252F726",
        "mainsnak" => {
          "snaktype" => "value",
          "property" => "P585",
          "datatype" => "time",
          "datavalue" => {
            "value" => {
              "time" => "-00000001200-01-01T00:00:00Z",
              "timezone" => 0,
              "before" => 0,
              "after" => 0,
              "precision" => 7,
              "calendarmodel" => "http://www.wikidata.org/entity/Q1985727"
            },
            "type" => "time"
          }
        },
        "type" => "statement",
        "rank" => "normal"
      }
    )
  }

  let(:year) {
    # http://www.wikidata.org/wiki/Q1118295
    described_class.new(
      {
        "id" => "Q1118295$DD125010-18CF-4280-9FB4-74735B5B8050",
        "mainsnak" => {
          "snaktype"=>"value",
          "property"=>"P571",
          "datatype"=>"time",
          "datavalue"=>{
            "value"=>{
              "time"=>"+00000001888-01-01T00:00:00Z",
              "timezone"=>0,
              "before"=>0,
              "after"=>0,
              "precision"=>9,
              "calendarmodel"=>"http://www.wikidata.org/entity/Q1985727"
            },
            "type"=>"time"
          }
        },
       "type"=>"statement",
       "rank"=>"normal"
      }
    )
  }

  let(:decade) {
    # http://www.wikidata.org/wiki/Q35014
    described_class.new(
      {
        "id"=>"Q35014$1B2CDE81-418E-4B0A-A775-408523C085B8",
        "mainsnak"=> {
          "snaktype"=>"value",
          "property"=>"P585",
          "datatype"=>"time",
          "datavalue"=> {
            "value"=>{
              "time"=>"+00000001970-01-01T00:00:00Z",
              "timezone"=>0,
              "before"=>0,
              "after"=>0,
              "precision"=>8,
              "calendarmodel"=>"http://www.wikidata.org/entity/Q1985727"
            },
            "type"=>"time"
          }
        },
       "type"=>"statement",
       "rank"=>"normal"
      }
    )
  }

  let(:decade_bc) {
    # http://www.wikidata.org/wiki/Q35014
    described_class.new(
      {
        "id"=>"Q35014$1B2CDE81-418E-4B0A-A775-408523C085B8",
        "mainsnak"=> {
          "snaktype"=>"value",
          "property"=>"P585",
          "datatype"=>"time",
          "datavalue"=> {
            "value"=>{
              "time"=>"-00000001970-01-01T00:00:00Z",
              "timezone"=>0,
              "before"=>0,
              "after"=>0,
              "precision"=>8,
              "calendarmodel"=>"http://www.wikidata.org/entity/Q1985727"
            },
            "type"=>"time"
          }
        },
       "type"=>"statement",
       "rank"=>"normal"
      }
    )
  }

  let(:month_leap) {
    described_class.new(
      {
        "id"=>"Q35014$1B2CDE81-418E-4B0A-A775-408523C085B8",
        "mainsnak"=> {
          "snaktype"=>"value",
          "property"=>"P585",
          "datatype"=>"time",
          "datavalue"=> {
            "value"=>{
              "time"=>"+00000002000-02-01T00:00:00Z",
              "timezone"=>0,
              "before"=>0,
              "after"=>0,
              "precision"=>10,
              "calendarmodel"=>"http://www.wikidata.org/entity/Q1985727"
            },
            "type"=>"time"
          }
        },
       "type"=>"statement",
       "rank"=>"normal"
      }
    )
  }

  let(:month_31) {
    described_class.new(
      {
        "id"=>"Q35014$1B2CDE81-418E-4B0A-A775-408523C085B8",
        "mainsnak"=> {
          "snaktype"=>"value",
          "property"=>"P585",
          "datatype"=>"time",
          "datavalue"=> {
            "value"=>{
              "time"=>"+00000001968-05-15T00:00:00Z",
              "timezone"=>0,
              "before"=>0,
              "after"=>0,
              "precision"=>10,
              "calendarmodel"=>"http://www.wikidata.org/entity/Q1985727"
            },
            "type"=>"time"
          }
        },
       "type"=>"statement",
       "rank"=>"normal"
      }
    )
  }

  let(:month_30) {
    described_class.new(
      {
        "id"=>"Q35014$1B2CDE81-418E-4B0A-A775-408523C085B8",
        "mainsnak"=> {
          "snaktype"=>"value",
          "property"=>"P585",
          "datatype"=>"time",
          "datavalue"=> {
            "value"=>{
              "time"=>"+00000001968-06-15T00:00:00Z",
              "timezone"=>0,
              "before"=>0,
              "after"=>0,
              "precision"=>10,
              "calendarmodel"=>"http://www.wikidata.org/entity/Q1985727"
            },
            "type"=>"time"
          }
        },
       "type"=>"statement",
       "rank"=>"normal"
      }
    )
  }

  let(:day) {
    described_class.new(
      {
        "mainsnak" => {
          "snaktype" => "value",
          "property" => "P569",
          "datatype" => "time",
          "datavalue" => {
            "value" => {
              "time" => "+00000001956-06-18T00:00:00Z",
              "timezone" => 0,
              "before" => 0,
              "after" => 0,
              "precision" => 11,
              "calendarmodel"=>"http://www.wikidata.org/entity/Q1985727"
            },
            "type" => "time"
          }
        },
        "type" => "statement",
        "rank"=>"normal"
      }
    )
  }


  describe 'leap year' do
    [1972, 1976, 1980, 1984, 1988, 1992, 1996, 2000, 2004, 2008, 2012, 2016].each do |y|
      it "should be true for #{y}" do
        described_class.leap_year?(y).should eq true
      end
    end
    [1974, 1978, 2014].each do |y|
      it "should be false for #{y}" do
        described_class.leap_year?(y).should eq false
      end
    end
  end

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
    bc_date.range.min.should eq DateTime.new(-2500000, 1, 1, 0, 0, 0)
    bc_date.range.max.should eq DateTime.new(-2500000, 1, 1, 0, 0, 0)
  end

  it 'should handle centuries' do
    century.range.min.should eq DateTime.new(1101, 1, 1, 0, 0, 0)
    century.range.max.should eq DateTime.new(1200, 12, 31, 23, 59, 59)
  end

  it 'should handle centuries BC' do
    century_bc.range.min.should eq DateTime.new(-1200, 1, 1, 0, 0, 0)
    century_bc.range.max.should eq DateTime.new(-1101, 12, 31, 23, 59, 59)
  end

  it 'should handle year' do
    year.range.min.should eq DateTime.new(1888, 1, 1, 0, 0, 0)
    year.range.max.should eq DateTime.new(1888, 12, 31, 23, 59, 59)
  end

  it 'should handle decade' do
    decade.range.min.should eq DateTime.new(1970, 1, 1, 0, 0, 0)
    decade.range.max.should eq DateTime.new(1979, 12, 31, 23, 59, 59)
  end

  it 'should handle decade BC' do
    decade_bc.range.min.should eq DateTime.new(-1979, 1, 1, 0, 0, 0)
    decade_bc.range.max.should eq DateTime.new(-1970, 12, 31, 23, 59, 59)
  end

  it 'should handle month (31 days)' do
    month_31.range.min.should eq DateTime.new(1968, 5, 1, 0, 0, 0)
    month_31.range.max.should eq DateTime.new(1968, 5, 31, 23, 59, 59)
  end

  it 'should handle month (30 days)' do
    month_30.range.min.should eq DateTime.new(1968, 6, 1, 0, 0, 0)
    month_30.range.max.should eq DateTime.new(1968, 6, 30, 23, 59, 59)
  end

  it 'should handle month (february and leap year)' do
    month_leap.range.min.should eq DateTime.new(2000, 2, 1, 0, 0, 0)
    month_leap.range.max.should eq DateTime.new(2000, 2, 29, 23, 59, 59)
  end

  it 'should handle day' do
    day.range.min.should eq DateTime.new(1956, 6, 18, 0, 0, 0)
    day.range.max.should eq DateTime.new(1956, 6, 18, 23, 59, 59)
  end
end
