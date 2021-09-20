# perform work of users load onto the db
class UsersWorker
  include Sidekiq::Worker

  def perform(*)
    # url = 'https://microverse-api-app.herokuapp.com/users?limit=10'
    url = 'http://localhost:3005/users'
    response = RestClient.get url, { Authorization: 'Bearer secret' }

    users = JSON.parse(response.body, symbolize_names: true)

    users.each do |x|
      User.create(name: x[:name])
    end
  rescue StandardError
    puts 'error'
  end
end
