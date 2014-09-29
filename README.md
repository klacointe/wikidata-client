# Wikidata API Client

[![Build Status](https://travis-ci.org/klacointe/wikidata-client.svg?branch=master)](https://travis-ci.org/klacointe/wikidata-client)
[![Code Climate](https://codeclimate.com/github/klacointe/wikidata-client/badges/gpa.svg)](https://codeclimate.com/github/klacointe/wikidata-client)
[![Test Coverage](https://codeclimate.com/github/klacointe/wikidata-client/badges/coverage.svg)](https://codeclimate.com/github/klacointe/wikidata-client)
[![Dependency Status](https://gemnasium.com/klacointe/wikidata-client.svg)](https://gemnasium.com/klacointe/wikidata-client)


[Wikidata](http://www.wikidata.org/) client library for Ruby.

It provide an easy way to search for wikidata pages and read their contents.


## Installation

In bunler: `gem 'wikidata-client', '~> 0.0.1'`

Otherwise: `gem install wikidata-client`


## Configuration

Only one thing is configurable for now, the HTTP client [patron](https://github.com/toland/patron)

```ruby
Wikidata.configure do |c|
  c.client_options = {
    request: {
      open_timeout: 2,
      timeout: 9
    }
  }
end
```

## Usage


### Search

```irb
> require 'wikidata'

> search = Wikidata::Item.search 'Homer Simpson'
=> <Wikidata::SearchResponse results: [
     <Wikidata::Item id: Q7810, title: "Homer Simpson">,
     <Wikidata::Item id: Q3577370, title: "Homer Simpson, This Is Your Wife">,
     <Wikidata::Item id: Q2082128, title: "Homer Simpson in: "Kidney Trouble">,
     <Wikidata::Item id: Q2715733, title: "Politically Inept, with Homer Simpson">,
     <Wikidata::Item id: Q1626047, title: "The City of New York vs. Homer Simpson">,
     <Wikidata::Item id: Q5966549, title: "Q5966549">,
     <Wikidata::Item id: Q15162647, title: "Being Homer Simpson">,
     <Wikidata::Item id: Q17653635, title: "'Homer Simpson' contributes to U.S. presidential candidate Buddy Roemer">,
     <Wikidata::Item id: Q17713638, title: "Q17713638">,
     <Wikidata::Item id: Q2751406, title: "Q2751406">
   ]>

> search.empty?
=> false

> search.results.first.labels['en'].value
=> "Homer Simpson"

> search.total_hits
=> 119

> search.next_page_offset
=> 10
```

### Find by ids or titles

```irb
> require 'wikidata'

> homer = Wikidata::Item.find_by_title 'Homer Simpson' # Same as homer = Wikidata::Item.find 'Q7810'
=> <Wikidata::Item id: Q7810, title: "Homer Simpson">

> homer.children
=> [<Wikidata::Item id: Q5480, title: "Bart Simpson">, <Wikidata::Item id: Q5846, title: "Lisa Simpson">, <Wikidata::Item id: Q7834, title: "Maggie Simpson">]

> homer.date_of_birth.date
=> #<DateTime: 1956-06-18T00:00:00+00:00 ((2435643j,0s,0n),+0s,2299161j)>
```


If you want several pages at the same time, just give an array to `find` or `find_by_title` methods:

```irb
> Wikidata::Item.find_by_title ['Sid Vicious', 'John Lydon']
=> <Wikidata::Response results: [
     <Wikidata::Item id: Q47878, title: "Sid Vicious">,
     <Wikidata::Item id: Q106662, title: "John Lydon">
   ]>

> Wikidata::Item.find ['Q47878', 'Q106662']
=> <Wikidata::Response results: [
     <Wikidata::Item id: Q47878, title: "Sid Vicious">,
     <Wikidata::Item id: Q106662, title: "John Lydon">
   ]>
```

## Properties

FIXME

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version
unintentionally.
* Commit, do not mess with rakefile, version, or history. (if you want to have
your own version, that is fine but bump version in a commit by itself in another
branch so I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.


## Copyright

MIT. See LICENSE for further details.
