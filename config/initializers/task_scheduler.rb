scheduler = Rufus::Scheduler.start_new  
logger = RAILS_DEFAULT_LOGGER
  
scheduler.every("1m") do  
  require "uri"
  require "net/http"
  
  date = Time.now.day
  if (date == 18 || date ==19 || date == 20 || date == 21 ||
      date == 26 || date == 27 || date == 28 || date == 29 ||
      date == 3 || date == 5)
    params = {'player'=>'http://rivals.yahoo.com/ncaa/basketball/scoreboard'}
    Net::HTTP.post_form(URI.parse("http://localhost:3000/players/update_page"), params)
  end
end   
