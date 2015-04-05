# Soccer Scraper GOOOOOOOOOLLLLL!!!

This Rails application is designed to scrape a website to obtain the
latest MLS soccer scores.

These scores will be stored in the database and then can be viewed by
the client. The client can interact with the data via a REST
interface.

### Getting Started

*   Checkout the code: git clone https://github.com/samiam/scraper.git
*   Install gems:  bundle install
*   Create the database:  rake db:migrate
*   Seed the database: rake db:seed
*   Start Rails: bin/rails server
*   Visit [http://localhost:3000/matches](http://localhost:3000/matches)
*   Enjoy the scores!


### Details

The website I choose to scrape was http://www.livescore.com/.  They have all the soccer scores from around 
the world from various leagues.

I wanted to limit the scope of the project to Major League Soccer scores.  I choose to seed the database using the last 30 days worth of scores.  http://www.livescore.com/soccer/usa/mls/results/30-days/

It turns out livescore.com is a restful website to begin with and the scraping could be extended to other leagues.

Although I have not used *Mechanize* in the past, I had heard of it and knew it would meet my needs.  I was pleased to find the Ruby version.  Once the website was scraped and a parser was created, it was all Nokogiri and xpath to extract the data.

The website is just a basic Rails app with the standard REST interface.  It's pretty plain without any CSS.  Of course there's room for lots of improvements such as sorting, avoiding duplicates, etc.

Feedback welcome.
