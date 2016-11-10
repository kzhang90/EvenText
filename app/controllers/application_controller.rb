class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # around_filter :user_time_zone, :if => :current_user

  def index
    @user = current_user
    # @bookmarks = @user.bookmarks
  end

  def after_sign_in_path_for(resource)
    edit_user_registration_path(resource)
  end

  def search_apis
    start_date = params[:start_date].to_s.downcase
    end_date = params[:end_date].to_s.downcase
    keyword = params[:keyword].to_s.downcase
    city = params[:city].to_s.downcase

    var = URI.escape('https://www.eventbriteapi.com/v3/events/search?q='+
      keyword+'&sort_by=best&location.address='+city+'&start_date.range_start='+
      start_date+'T00:00:00Z&start_date.range_end='+end_date+'T00:00:00Z')

    # resource = RestClient::Request.execute method: :get, url: var, headers: {Authorization: ENV['EVENTBRITE']}
    binding.pry

    first_response = RestClient.get var, {params: {'token' => ENV['TOKEN']}}



    # first_response = RestClient.get(var,
    #   authorization: ENV['EVENTBRITE']
    # )

    # first_response = RestClient::Request.execute(
    #                   :method => :get, 
    #                   :url => var, 
    #                   :headers => {authorization: 'Bearer 3PQLXFDASEKEJXXFKWZN'}
    #                 )
    response = JSON.parse first_response

    @events = response["events"]
    @bookmarks = @events.map { |event|
      if event["description"]["text"] && event["name"]["text"]
        Bookmark.new(
          title: event["name"]["text"],
          image: event["logo"].nil? ? "" : event["logo"]["url"],
          description: event["description"]["text"].match(/^.*?[\.!\?](\s|$)/).to_s.gsub("\n"," "),
          time: event["start"]["local"].split("T")[0] + " " + event["start"]["local"].split("T")[1],
          url: event["url"])
      end
    }

    @st = @bookmarks.map do |f|
      if !f.nil?
        {
          "title" => f.title,
          "image" => f.image,
          "description" => f.description,
          "location" => params[:city],
          "time" => f.time,
          "url" => f.url
        }
      end
    end
    @st = @st - [nil]

    render :json => @st
  end
# take js controller is sending and js is transposing json to html
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :avatar, :password, :current_password, :password_confirmation])    
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :avatar, :password, :password_confirmation])
  end

  # def user_time_zone(&block)
  #   Time.use_zone(current_user.time_zone, &block)
  # end

end
