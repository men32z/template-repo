require 'rails_helper'

describe UserLoader::Microverse do
  describe 'users loader service Microverse class' do
    it 'loads users from api' do
      users_response = [
        {
          id: 1,
          first_name: 'Angelyn',
          last_name: 'Von',
          status: 'Inactive',
          created_at: '2021-02-08T05:05:19.405Z',
          email: 'oscarleuschke@koelpin.biz'
        }
      ]
      stub_request(:get, 'https://microverse-api-app.herokuapp.com/users?limit=10')
        .to_return(status: 200, body: users_response.to_json)

      UserLoader::Microverse.call({ limit: 10 })
      user = User.find_by(external_id: 1)
      expect(user.first_name).to eq('Angelyn')
    end

    it 'loads unique users from api' do
      users_response = [
        {
          id: 1,
          first_name: 'Angelyn',
          last_name: 'Von',
          status: 'Inactive',
          created_at: '2021-02-08T05:05:19.405Z',
          email: 'oscarleuschke@koelpin.biz'
        },
        {
          id: 1,
          first_name: 'Angelyn',
          last_name: 'Von',
          status: 'Inactive',
          created_at: '2021-02-08T05:05:19.405Z',
          email: 'oscarleuschke@koelpin.biz'
        }
      ]
      stub_request(:get, 'https://microverse-api-app.herokuapp.com/users?limit=10')
        .to_return(status: 200, body: users_response.to_json)

      UserLoader::Microverse.call({ limit: 10 })
      users = User.where(email: 'oscarleuschke@koelpin.biz')
      expect(users.length).to eq(1)
    end
    it "creates new downcase status if doesn't exist" do
      users_response = [
        {
          id: 1,
          first_name: 'Angelyn',
          last_name: 'Von',
          status: 'NewStatus',
          created_at: '2021-02-08T05:05:19.405Z',
          email: 'oscarleuschke@koelpin.biz'
        }
      ]
      stub_request(:get, 'https://microverse-api-app.herokuapp.com/users?limit=10')
        .to_return(status: 200, body: users_response.to_json)

      old_length = UserStatus.where(name: 'newstatus').length
      expect(old_length).to eq(0)
      UserLoader::Microverse.call({ limit: 10 })
      new_length = UserStatus.where(name: 'newstatus').length
      expect(new_length).to eq(1)
    end

    it "creates only one new downcase status if doesn't exist" do
      users_response = [
        {
          id: 1,
          first_name: 'Angelyn',
          last_name: 'Von',
          status: 'weird',
          created_at: '2021-02-08T05:05:19.405Z',
          email: 'oscarleuschke@koelpin.biz'
        },
        {
          id: 97,
          first_name: 'Anton',
          last_name: 'Sanchez',
          status: 'weird',
          created_at: '2019-11-23T22:44:32.431Z',
          email: 'thaddeusgoldner@gleason.info'
        }
      ]
      stub_request(:get, 'https://microverse-api-app.herokuapp.com/users?limit=10')
        .to_return(status: 200, body: users_response.to_json)

      expect { UserLoader::Microverse.call({ limit: 10 }) }.to change { UserStatus.where(name: 'weird').length }.by(1)
    end
  end
end
