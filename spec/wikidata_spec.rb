require 'spec_helper'

describe Wikidata do
  let(:options) do
    { request: { timeout: 10 } }
  end
  it 'should be configurable' do
    Wikidata.configure do |c|
      c.options = options
      c.adapter = :excon
    end
    Wikidata.options.should be options
    Wikidata.adapter.should be :excon
  end
end
