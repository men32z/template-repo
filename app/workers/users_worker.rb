# perform work of users load onto the db
class UsersWorker
  include Sidekiq::Worker

  def perform(page = 0)
    new_users = UserLoader::Microverse.call({ limit: 10, offset: page * 10 })
    # we could use dealy depending on what are we looking for.
    UsersWorker.perform_async(page + 1) if new_users && new_users.length > 1
  end
end
