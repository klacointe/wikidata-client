require 'spec_helper'

describe Wikidata::Item, :vcr do

  describe '#find:' do
    let(:entity_by_id) { Wikidata::Item.find 'Q2831' }
    let(:entity_by_title) { Wikidata::Item.find_by_title 'Michael Jackson' }
    let(:collection_by_id) { Wikidata::Item.find ['Q2831', 'Q47878'] }
    let(:collection_by_title) { Wikidata::Item.find_by_title ['Michael Jackson', 'Sid Vicious'] }

    it 'should raise an error of item not found' do
      lambda {
        Wikidata::Item.find 'THISISNOTAVALIDID'
      }.should raise_error Wikidata::ItemNotFound
    end

    it 'should raise an error of missing search' do
      lambda {
        Wikidata::Item.search ''
      }.should raise_error Wikidata::SearchMissing
    end

    it 'should find by id' do
      entity_by_id.should be_kind_of Wikidata::Item
    end

    it 'should find by title' do
      entity_by_title.should be_kind_of Wikidata::Item
    end

    it 'should find by ids' do
      collection_by_id.size.should eq 2
      collection_by_id.each{|i| i.should be_kind_of Wikidata::Item }
    end

    it 'should find by titles' do
      collection_by_title.size.should eq 2
      collection_by_title.each{|i| i.should be_kind_of Wikidata::Item }
    end
  end

  describe '#search' do
    let(:search) { Wikidata::Item.search 'Sid Vicious' }

    it 'should return an array of Wikidata::Item' do
      search.size.should eq 10
      search.each{|i| i.should be_kind_of Wikidata::Item }
    end

    it 'should request all item of the collection' do
      search.first.descriptions.pl.value.should eq 'brytyjski muzyk punkowy (Sex Pistols)'
    end
  end
end
