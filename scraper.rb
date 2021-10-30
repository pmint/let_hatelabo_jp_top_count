#!/usr/bin/env ruby

# let.hatelabo.jp top_count
# from ScraperWiki

require 'scraperwiki'
require 'nokogiri'

# Saving data:
# unique_keys = [ 'id' ]
# data = { 'id'=>12, 'name'=>'violet', 'age'=> 7 }
# ScraperWiki.save_sqlite(unique_keys, data)



url = "https://let.hatelabo.jp/"

charset = nil
html = open(url) do |f|
  charset = f.charset
  f.read
end
doc = Nokogiri::HTML.parse(html, nil, charset)

doc.xpath('//*[@id="top-message"]/p[@class="top-count-container"]/span').text =~ /(\d+)\s+Bookmarklets/
p $1
ScraperWiki.save_sqlite(['id'], {
    'id' => Time.now.to_i,
    'top_count_blob' => $1,
    'time_blob' => Time.now.getlocal('+09:00').to_s
})


# This is a template for a Ruby scraper on Morph (https://morph.io)
# including some code snippets below that you should find helpful

# require 'scraperwiki'
# require 'mechanize'
#
# agent = Mechanize.new
#
# # Read in a page
# page = agent.get("http://foo.com")
#
# # Find somehing on the page using css selectors
# p page.at('div.content')
#
# # Write out to the sqlite database using scraperwiki library
# ScraperWiki.save_sqlite(["name"], {"name" => "susan", "occupation" => "software developer"})
#
# # An arbitrary query against the database
# ScraperWiki.select("* from data where 'name'='peter'")

# You don't have to do things with the Mechanize or ScraperWiki libraries. You can use whatever gems are installed
# on Morph for Ruby (https://github.com/openaustralia/morph-docker-ruby/blob/master/Gemfile) and all that matters
# is that your final data is written to an Sqlite database called data.sqlite in the current working directory which
# has at least a table called data.
