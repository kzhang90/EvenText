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

    # yelp API
    # parameters = { term: params[:term], limit: }
    # render json: Yelp.client.search('San Francisco', parameters)

    response = JSON.parse RestClient.get('https://www.eventbriteapi.com/v3/events/search?q='+
      keyword+'&sort_by=best&venue.city='+city+'&start_date.range_start='+
      start_date+'T00:00:00Z&start_date.range_end='+end_date+
      'T00:00:00Z&token=H3MJZUEJ6CMP2XNVST3C')
    # use line 28 to view response, then comment out and uncomment 29 & 30 for the actual view code
    # render json: response
    @events = response["events"][0]
    # make an array of bookmarks
    # need to handle empty responses.
    @bookmarks = @events.map {
      |event| Bookmark.new(name: event.name)
    }
    # save 

    # @events is an array of objects where the top 10 are displayed 
    # data in js file is @events once it is rednered as :json
    respond_to do |format|
      format.js {}
      format.json {render :json => @bookmarks, location: @bookmarks}
    end
    # render :index
  end

end