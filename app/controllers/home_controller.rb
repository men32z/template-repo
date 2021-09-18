# Controller to handle public pages.
class HomeController < ActionController::Base
  def index
    render 'layouts/application'
  end
end
