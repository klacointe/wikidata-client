require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'wikidata'
require 'vcr'
require 'pry'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = [:should, :expect]
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  VCR.configure do |c|
    c.cassette_library_dir = 'spec/fixtures/vcr'
    c.default_cassette_options = { record: :new_episodes }
    c.hook_into :webmock
    c.allow_http_connections_when_no_cassette = true
    c.configure_rspec_metadata!
  end
end
