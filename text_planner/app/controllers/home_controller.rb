class HomeController < ApplicationController
  # add before_action :confirm_logged_in except: [:method]
  def index
    @user = current_user
  end

  def searchApis
    start_date = params[:start_date].to_s
    end_date = params[:start_date].to_s
    keyword = params[:keyword].to_s
    city = params[:city].to_s

    eventbrite_request = Typhoeus::Request.new('https://www.eventbriteapi.com/v3/events/search?q='+keyword+'&sort_by=best&venue.city='+city+'&start_date.range_start='+start_date+'T00:00:00Z&start_date.range_end='+end_date+'T00:00:00Z',
                                  method: :get,
                                  headers: { 'Authorization' => ENV['EVENTBRITE']}).run
    @response = eventbrite_request

    # yelp_request = Typhoeus::Request.new('',
    #                                   )
    # set @result to be the data that I want.
    render 'index'
  end


end
