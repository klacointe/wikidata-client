require 'spec_helper'

describe Wikidata do
  let(:builder) {
    -> (builder) {
      builder.options[:request] = {
        timeout: 10,
        open_timeout: 2
      }
      builder.use :excon
    }
  }
  it 'should be configurable' do
    Wikidata.configure do |c|
      c.faraday = builder
    end
    Wikidata.faraday.should be builder
  end
end
