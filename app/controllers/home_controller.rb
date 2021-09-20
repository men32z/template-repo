# Controller to handle public pages.
class HomeController < ActionController::Base
  def index
    render 'layouts/application'
  end

  # runs the worker for now. 
  def test
    UsersWorker.perform_async()
    render '/test'
  end
end
