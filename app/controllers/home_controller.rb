# Controller to handle public pages.
class HomeController < ActionController::Base
  def index
    render 'layouts/application'
  end

  # runs the worker for now.
  def test
    # we could also send startign page(10 users will be loaded per page).
    UsersWorker.perform_async
    render '/test'
  end
end
