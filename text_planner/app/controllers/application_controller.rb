class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def index
  end

  def after_sign_in_path_for(resource)
    "/"
  end

  def search_apis
    start_date = params[:start_date].to_s
    end_date = params[:end_date].to_s
    keyword = params[:keyword].to_s
    city = params[:city].to_s


    response = JSON.parse RestClient.get('https://www.eventbriteapi.com/v3/events/search?q='+keyword+'&sort_by=best&venue.city='+city+'&start_date.range_start='+start_date+'T00:00:00Z&start_date.range_end='+end_date+'T00:00:00Z&token=H3MJZUEJ6CMP2XNVST3C')
    # use line 21 to view response, then comment out and uncomment 22 & 23 for the actual view code
    # render json: response
    @events = response["events"]
    render :json => @events
    # render :index
  end

end