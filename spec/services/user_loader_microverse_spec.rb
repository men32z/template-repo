require 'rails_helper'

describe UserLoader::Microverse do
  let(:user_api) do
    {
      id: 1,
      first_name: 'Angelyn',
      last_name: 'Von',
      status: 'Inactive',
      created_at: '2021-02-08T05:05:19.405Z',
      email: 'oscarleuschke@koelpin.biz'
    }
  end

  describe 'users loader service Microverse class' do
    it 'loads users from api' do
      users_response = [user_api.clone]
      stub_request(:get, 'https://microverse-api-app.herokuapp.com/users?limit=10')
        .to_return(status: 200, body: users_response.to_json)

      UserLoader::Microverse.call({ limit: 10 })
      user = User.find_by(external_id: 1)
      expect(user.first_name).to eq('Angelyn')
    end

    it 'loads unique users from api' do
      # duplicate the user so we try to load two times the same.
      users_response = [user_api.clone, user_api.clone]
      stub_request(:get, 'https://microverse-api-app.herokuapp.com/users?limit=10')
        .to_return(status: 200, body: users_response.to_json)

      UserLoader::Microverse.call({ limit: 10 })
      users = User.where(email: 'oscarleuschke@koelpin.biz')
      expect(users.length).to eq(1)
    end
    it "creates new downcase status if doesn't exist" do
      users_response = [user_api.clone]
      users_response[0][:status] = 'NewStatus'
      stub_request(:get, 'https://microverse-api-app.herokuapp.com/users?limit=10')
        .to_return(status: 200, body: users_response.to_json)

      old_length = UserStatus.where(name: 'newstatus').length
      expect(old_length).to eq(0)
      UserLoader::Microverse.call({ limit: 10 })
      new_length = UserStatus.where(name: 'newstatus').length
      expect(new_length).to eq(1)
    end

    it "creates only one new downcase status if doesn't exist" do
      users_response = [user_api.clone, user_api.clone]
      users_response[0][:status] = 'weird'
      users_response[1][:status] = 'weird'
      users_response[1][:id] = 97 # different id
      users_response[1][:email] = 'different_email@gleason.info'

      stub_request(:get, 'https://microverse-api-app.herokuapp.com/users?limit=10')
        .to_return(status: 200, body: users_response.to_json)

      expect { UserLoader::Microverse.call({ limit: 10 }) }
        .to change { UserStatus.where(name: 'weird').length }.by(1)
        .and change { User.count }.by(2)
    end
  end
end
