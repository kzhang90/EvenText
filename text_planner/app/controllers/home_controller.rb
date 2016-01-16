class HomeController < ApplicationController
  # add before_action :confirm_logged_in except: [:method]
  def index
  end

  def searchApis
    start_date = params[:start_date]
    end_date = params[:start_date]
    start_date_time = params[:start_time](13:00:00)
    end_date_time = params[:end_time]

    eventbrite_request = Typhoeus::Request.new('https://www.eventbriteapi.com/v3/events/search?q='+keyword+'&sort_by=best&venue.city='+city+'&start_date.range_start='+start_date+'T'+start_date_time+'Z&start_date.range_end='+end_date+'T'+end_date_time+'Z',
                                  method: :get,
                                  headers: { 'Authorization' => ENV['EVENTBRITE']})
    response = event_request["events"][0]

    yelp_request = Typhoeus::Request.new('',
                                      )
    # set @result to be the data that I want.
  end


end
