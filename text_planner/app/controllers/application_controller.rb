class ApplicationController < ActionController::Base

  before_filter :configure_permitted_parameters, if: :devise_controller?
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

    response = JSON.parse RestClient.get('https://www.eventbriteapi.com/v3/events/search?q='+
      keyword+'&sort_by=best&venue.city='+city+'&start_date.range_start='+
      start_date+'T00:00:00Z&start_date.range_end='+end_date+
      'T00:00:00Z',
        {
          :Authorization => ENV['EVENTBRITE_AUTH']
        })

    @events = response["events"]

    @bookmarks = @events.map {
      |event| Bookmark.new(
        title: event["name"]["text"],
        image: event["logo"].nil? ? "NULL" : event["logo"]["url"],
        description: event["description"]["text"].gsub!("\n"," "),
        date: event["start"]["local"].split("T")[0],
        time: event["start"]["local"].split("T")[1],
        url: event["url"]
    )}

    respond_to do |format|
      format.js {}
      format.json {render :json => @bookmarks, location: @bookmarks}
    end
  end


  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :phone_number, :username, :email, :password, :password_confirmation) }
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:first_name, :last_name, :phone_number, :username, :email, :password, :password_confirmation) }
    end
    
end