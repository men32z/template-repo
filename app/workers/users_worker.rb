# frozen_string_literal: true

# perform work of users load onto the db
class UsersWorker
  include Sidekiq::Worker

  def perform(*); end
end
