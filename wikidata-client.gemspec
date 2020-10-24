$:.push File.expand_path("../lib", __FILE__)
require "wikidata/version"

Gem::Specification.new do |s|
  s.name        = "wikidata-client"
  s.version     = Wikidata::VERSION.dup
  s.platform    = Gem::Platform::RUBY
  s.licenses    = ["MIT"]
  s.summary     = "Wikidata API client"
  s.email       = "kevinlacointe@gmail.com"
  s.homepage    = "https://github.com/klacointe/wikidata-client"
  s.authors     = ['Kévin Lacointe']

  s.files         = `git ls-files -- lib config *.md LICENCE`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency("faraday", "~> 1.1")
  s.add_dependency("faraday_middleware", "~> 1.0")
  s.add_dependency("hashie", "~> 4.1")
  s.add_dependency("excon", "~> 0.78")

  s.add_development_dependency("rspec", "~> 3.9")
  s.add_development_dependency("webmock", "~> 3.9")
  s.add_development_dependency("vcr", "~> 2.9")
  s.add_development_dependency("pry", "~> 0.13")
  s.add_development_dependency("rake", "~> 13.0")
end
