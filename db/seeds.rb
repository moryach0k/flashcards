# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('http://www.languagedaily.com/learn-german/vocabulary/common-german-words'))

rows = doc.search('//tbody//tr')
@details = rows.collect do |row|
    detail = {}
    [
      [:original_text, 'td[2]/text()'],
      [:translated_text, 'td[3]/text()'],
    ].each do |name, xpath|
      detail[name] = row.at_xpath(xpath).to_s.strip
    end
    detail
end

@details.each do |detail|
  Card.create(original_text: detail[:original_text], translated_text: detail[:translated_text], review_date: Time.now.to_date)
end