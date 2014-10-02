require 'spec_helper'

describe Wikidata::Item, :vcr do

  describe '#find:' do
    let(:entity_by_id) { Wikidata::Item.find 'Q2831' }
    let(:entity_by_title) { Wikidata::Item.find_by_title 'Michael Jackson' }
    let(:collection_by_id) { Wikidata::Item.find ['Q2831', 'Q47878'] }
    let(:collection_by_title) { Wikidata::Item.find_by_title ['Michael Jackson', 'Sid Vicious'] }

    it 'should return nil if item not found' do
      Wikidata::Item.find('THISISNOTAVALIDID').should be_nil
    end

    it 'should return nil if item title not found' do
      Wikidata::Item.find_by_title('THISISNOTAVALIDID', sites: 'enwiki').should be_nil
    end

    it 'should find by id' do
      entity_by_id.should be_kind_of Wikidata::Item
    end

    it 'should find by title' do
      entity_by_title.should be_kind_of Wikidata::Item
    end

    it 'should find by ids' do
      collection_by_id.size.should eq 2
      collection_by_id.should be_kind_of Wikidata::Response
      collection_by_id.results.each{|i| i.should be_kind_of Wikidata::Item }
    end

    it 'should find by titles' do
      collection_by_title.size.should eq 2
      collection_by_title.should be_kind_of Wikidata::Response
      collection_by_title.results.each{|i| i.should be_kind_of Wikidata::Item }
    end
  end

  describe '#search' do
    let(:search) { Wikidata::Item.search 'Michael Jackson' }

    it 'should return a response with an empty array of results if search missing' do
      Wikidata::Item.search('').tap do |s|
        s.should be_kind_of Wikidata::Response
        s.results.should be_empty
      end
    end

    it 'should return an array of Wikidata::Item' do
      search.size.should eq 10
      search.should be_kind_of Wikidata::SearchResponse
      search.results.each{|i| i.should be_kind_of Wikidata::Item }
    end

    it 'should return the total number of hits' do
      search.total_hits.should eq 416
    end

    it 'should return the next page offset' do
      search.next_page_offset.should eq 10
    end

    it 'should fetch all all items of the collection' do
      search.results.first.descriptions.pl.value.should eq 'amerykański muzyk, kompozytor i autor tekstów'
    end
  end
end
