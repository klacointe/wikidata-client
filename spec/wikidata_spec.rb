require 'spec_helper'

describe Wikidata do
  it 'should be configurable' do
    Wikidata.configure do |c|
      c.client_options = {
        request: {
          open_timeout: 10,
          timeout: 10
        }
      }
    end
    Wikidata.client_options.should eq({
      request: {
        open_timeout: 10,
        timeout: 10
      }
    })
  end
end
