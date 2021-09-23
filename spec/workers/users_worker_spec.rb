require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

# test are after pages declarations.
page1 = [
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

page2 = [
  {
    id: 99,
    first_name: 'Cathern',
    last_name: 'Balistreri',
    status: 'Active',
    created_at: '2017-05-26T18:47:21.467Z',
    email: 'bobbie@grady.co'
  },
  {
    id: 100,
    first_name: 'Vince',
    last_name: 'Stiedemann',
    status: 'Inactive',
    created_at: '2017-06-25T06:49:16.472Z',
    email: 'tieravon@herman.org'
  }
]

RSpec.describe UsersWorker, type: :worker do
  before(:each) do
    stub_request(:get, 'https://microverse-api-app.herokuapp.com/users?limit=10&offset=0')
      .to_return(status: 200, body: page1.to_json)

    stub_request(:get, 'https://microverse-api-app.herokuapp.com/users?limit=10&offset=10')
      .to_return(status: 200, body: page2.to_json)

    page3 = []
    stub_request(:get, 'https://microverse-api-app.herokuapp.com/users?limit=10&offset=20')
      .to_return(status: 200, body: page3.to_json)
  end
  describe 'test worker' do
    it 'job in correct queue' do
      described_class.perform_async
      assert_equal 'default', described_class.queue
    end

    it 'chain workers to paginate and load all the data.' do
      expect { UsersWorker.perform_async }.to change { User.count }.by(4)
    end
  end
end
