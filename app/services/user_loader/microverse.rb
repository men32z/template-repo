module UserLoader
  class Microverse < ApplicationService
    # disabled cause don't need to call super in a Service initializer
    # rubocop:disable Lint/MissingSuper, Lint/MissingCopEnableDirective
    def initialize(params)
      # url and headers, and external_provider
      # could come from db or env depending on planning.
      @url = 'https://microverse-api-app.herokuapp.com/users'
      @headers = { Authorization: ENV['USERS_API_KEY'] }
      @external_provider = 1

      @params = params
    end

    def call
      response = RestClient.get "#{@url}?#{@params.map { |k, v| "#{k}=#{v}" }.join('&')}", @headers
      users = JSON.parse(response.body, symbolize_names: true)
      mapped_users = []

      return [] unless users

      # get status
      statuses = UserStatus.all.map { |e| [e.name.to_sym, e.id] }.to_h

      users.each do |e|
        # we create a new status if we don't have it.
        unless statuses.keys.include? e[:status].downcase.to_sym
          new_status = UserStatus.create({ name: e[:status].downcase })
          statuses[new_status.name.to_sym] = new_status.id
        end

        mapped_users << {
          first_name: e[:first_name],
          last_name: e[:last_name],
          email: e[:email],
          external_id: e[:id],
          status_id: statuses[e[:status].downcase.to_sym],
          external_provider: @external_provider,
          external_created_at: e[:created_at]
        }
      end

      User.create(mapped_users)
    rescue StandardError => e
      # TODO: log this into the database with other usefull info maybe?
      puts "An error of type #{e.class} happened, message is #{e.message}"
      []
    end
  end
end
