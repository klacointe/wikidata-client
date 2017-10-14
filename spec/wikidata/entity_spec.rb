require 'spec_helper'

describe Wikidata::Entity, :vcr do
  let(:sid) { Wikidata::Item.find_by_title 'Sid Vicious' }
  let(:homer) { Wikidata::Item.find_by_title 'Homer Simpson' }
  let(:batofar) { Wikidata::Item.find_by_title 'Le Batofar' }
  let(:github) { Wikidata::Item.find_by_title 'GitHub' }

  describe 'properties' do

    it 'should return id' do
      sid.id.should eq 'Q47878'
    end

    it 'should return url' do
      sid.url.should eq 'https://www.wikidata.org/wiki/Q47878'
    end

    it 'should return labels' do
      sid.labels.en.value.should eq 'Sid Vicious'
      sid.labels.ja.value.should eq 'シド・ヴィシャス'
    end

    it 'should return aliases' do
      sid.aliases.en.map(&:value).should include('John Simon Ritchie', 'Здох через шлюху')
      sid.aliases.ja.map(&:value).should include('シド・ビシャス')
    end

    it 'should return descriptions' do
      sid.descriptions.en.value.should eq 'Bassist, songwriter, composer'
    end

    it 'should return sitelinks' do
      sid.sitelinks.frwiki.should eq({"site"=>"frwiki", "title"=>"Sid Vicious", "badges"=>[]})
    end

    describe 'entities' do

      it 'should return entities property from an id (P40 for children here)' do
        homer.properties('P40').tap do |children|
          children.size.should eq 3
          children.each{|c| c.should be_kind_of Wikidata::Item }
          children.map{|c| c.labels['en']['value'] }.should eq ['Bart Simpson', 'Lisa Simpson', 'Maggie Simpson']
        end
      end

      it 'should return entities property from a key (children here)' do
        homer.children.tap do |children|
          children.size.should eq 3
          children.each{|c| c.should be_kind_of Wikidata::Item }
          children.map{|c| c.labels['en']['value'] }.should eq ['Bart Simpson', 'Lisa Simpson', 'Maggie Simpson']
        end
      end

      it 'should allow to return only entities ids from an id' do
        homer.property_ids('P40').should eq ["Q5480", "Q5846", "Q7834"]
      end

      it 'should allow to return only entities ids from a key' do
        homer.children_ids.should eq ["Q5480", "Q5846", "Q7834"]
      end
    end

    describe 'properties' do

      context 'of type date' do
        it 'should return Time from a property id (P569 for date of birth here)' do
          homer.property('P569').tap do |date|
            date.should be_kind_of Wikidata::Property::Time
            date.date.should eq DateTime.new(1956, 6, 18)
          end
        end

        it 'should return Time from a a key (date_of_birth here)' do
          homer.date_of_birth.tap do |date|
            date.should be_kind_of Wikidata::Property::Time
            date.date.should eq DateTime.new(1956, 6, 18)
          end
        end
      end

      context 'of type globe coordinate' do
        it 'should return GlobeCoordinate from a property id (P625 for coordinate location here)' do
          batofar.property('P625').tap do |c|
            c.should be_kind_of Wikidata::Property::GlobeCoordinate
            c.latitude.should eq 48.83337778
            c.longitude.should eq 2.37925278
          end
        end

        it 'should return GlobeCoordinate from a key (coordinate_location here)' do
          batofar.coordinate_location.tap do |c|
            c.should be_kind_of Wikidata::Property::GlobeCoordinate
            c.latitude.should eq 48.83337778
            c.longitude.should eq 2.37925278
          end
        end
      end

      context 'of type string' do
        it 'should return String from a property id (P646 for freebase identifier here)' do
          homer.property('P646').tap do |c|
            c.should be_kind_of Wikidata::Property::String
            c.value.should eq '/m/0h545'
          end
        end

        it 'should return String from a key (freebase_identifier here)' do
          homer.freebase_identifier.tap do |c|
            c.should be_kind_of Wikidata::Property::String
            c.value.should eq '/m/0h545'
          end
        end

        it 'should return a nil property_id if not an item' do
          homer.property_id('P646').should be_nil
        end
      end

      context 'of type url' do
        it 'should return Url from a property id (P856 for official website here)' do
          github.property('P856').tap do |c|
            c.should be_kind_of Wikidata::Property::Url
            c.value.should eq 'https://github.com'
          end
        end

        it 'should return Url from a key (official_website here)' do
          github.official_website.tap do |c|
            c.should be_kind_of Wikidata::Property::Url
            c.value.should eq 'https://github.com'
          end
        end
      end

      context 'of type commons media' do
        it 'should return CommonsMedia from a property id (P154 for logo image here)' do
          github.property('P154').tap do |c|
            c.should be_kind_of Wikidata::Property::CommonsMedia
            c.value.should eq 'GitHub logo 2013.svg'
          end
        end

        it 'should return CommonsMedia from a key (logo_image here)' do
          github.logo_image.tap do |c|
            c.should be_kind_of Wikidata::Property::CommonsMedia
            c.value.should eq 'GitHub logo 2013.svg'
          end
        end
      end

      it 'can get a list of all property keys' do
        github.property_keys.size.should be > 0
      end

      it 'can get the name of a property' do
        github.property_name("P31").should eq 'instance of'
      end
    end
  end
end
