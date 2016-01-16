class WelcomeController < ApplicationController
  def index
    # render the welcome index if theres nothing there already.
    @try = {"this":"object", "3":true}
  end

end
