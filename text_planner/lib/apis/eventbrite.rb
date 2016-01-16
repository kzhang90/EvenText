require 'HTTParty'
  
class EventBriteApi
  base_uri 'eventbriteapi.com'
  # start_date.range_start: "2010-01-31T13:00:00Z"
  # start_date.range_end: "2015-01-31T13:00:00Z"
  # q: event keyword
  # venue.city
  # hard-code: sort_by, best
  # header authorization "Bearer H3MJZUEJ6CMP2XNVST3C"

  def initialize(keyword, city, start_date, end_date)
    @options = { query: {q: keyword, venue.city: city, start_date.range_start: start_date, start_date.range_end: end_date}}
  end

  def events
    self.class.get("/v3/events", @options)
  end
end