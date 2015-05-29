require 'spec_helper'

describe Wikidata::Property::CommonsMedia do
  let(:image) {
    described_class.new(
      {
        'id' =>  'Q6882$8CB12994-045E-4EB3-98F8-3975EA1BF9A7',
        'mainsnak' =>  {
          'snaktype' =>  'value',
          'property' =>  'P18',
          'datatype' =>  'commonsMedia',
          'datavalue' =>  {
            'value' =>  'Revolutionary Joyce Better Contrast.jpg',
            'type' =>  'string'
          }
        },
        'type' =>  'statement',
        'rank' =>  'normal',
        'references' =>  [
          {
            'hash' =>  'd6e3ab4045fb3f3feea77895bc6b27e663fc878a',
            'snaks' =>  {
              'P143' =>  [
                {
                  'snaktype' =>  'value',
                  'property' =>  'P143',
                  'datatype' =>  'wikibase-item',
                  'datavalue' =>  {
                    'value' =>  {
                      'entity-type' =>  'item',
                      'numeric-id' =>  206855
                    },
                    'type' =>  'wikibase-entityid'
                  }
                }
              ]
            },
            'snaks-order' =>  ['P143']
          }
        ]
      }
    )
  }

  describe 'image' do
    it "should return image page url" do
      image.page_url.should eq "https://commons.wikimedia.org/wiki/File:Revolutionary_Joyce_Better_Contrast.jpg"
    end

    it "should return image extension" do
      image.extension.should eq "jpg"
    end

    it "should return image name" do
      image.name.should eq "Revolutionary Joyce Better Contrast"
    end

    it "should return image file base name" do
      image.basename.should eq "Revolutionary_Joyce_Better_Contrast"
    end

    it "should return image url" do
      image.url.should eq "https://upload.wikimedia.org/wikipedia/commons/1/1e/Revolutionary_Joyce_Better_Contrast.jpg"
    end

    it "should return image url for a given size" do
      image.url(200).should eq "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Revolutionary_Joyce_Better_Contrast.jpg/200px-Revolutionary_Joyce_Better_Contrast.jpg"
    end
  end
end
