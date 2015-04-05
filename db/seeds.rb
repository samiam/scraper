# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'mechanize'

# Location to scrape data from
location = "http://www.livescore.com/soccer/usa/usl-pro/results/30-days/"

# Create Mechanize object to fetch url
puts "Fetching data from #{location}..."
agent = Mechanize.new
r = agent.get(location)

# Create Nokogiri parser
parser = r.parser
puts "Parsing elements..."

# Testing - parse a local file instead of fetching url
#parser = Nokogiri::HTML(open("/Users/sam/work/scraper/mechanize/LiveScore Soccer - USL Pro Last 7 Days Results, USA.html"))

dt_s = nil    # date string
count = 0

# Look at each div plucking ones needed
# Have to go through them all as date is outside of match element, so
# once a date is found, subsequent matches were on that date until next
# date found.
parser.xpath('//div').each do |div|

  # Get the date
  if div['class'] == "tright fs11"
    dt = div.content
    dt_s = Date.parse(dt).to_s
  end

  # A row containing a match on that date
  if div['class'] =~ /row-gray/
    # Returns Element
    min = div.xpath('./div[@class = "min"]').inner_html
    visitor = div.xpath('./div[@class = "ply tright name"]').inner_html
    home = div.xpath('./div[@class = "ply name"]').inner_html

    # Returns NodeSet
    score = div.xpath('./div[@class = "sco"]').first.content
    vscore, hscore = score.split('-', 2)

    # Normalize
    [dt_s, vscore, hscore, min, visitor, home].map { |m| m.strip! }

    # Create match
    match = Match.new(:visitor => visitor,
                      :home => home,
                      :visitor_points => vscore,
                      :home_points => hscore,
                      :date => dt_s)

    # What was problem with saving?
    if match.save
      count += 1;
    else
      puts match.errors.messages
    end
  end
end

puts "Seeded #{count} matches"
