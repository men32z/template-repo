require 'rails_helper'

RSpec.describe 'Users actions', type: :feature do
  fixtures :users

  let(:user_valid) do
    {
      id: 1,
      first_name: 'Mike',
      last_name: 'Wazowski',
      email: 'mike@monstersinc.com',
      status_id: 1 # status are seeded.
    }
  end

  describe '/users' do
    scenario 'Index Should show the list of users' do
      user = User.create(user_valid)
      visit users_path
      expect(page).to have_content user.first_name
      expect(page).to have_content user.last_name
    end
  end

  describe '/users/:id' do
    it 'finds user name on the page' do
      one_user = User.create(user_valid)
      visit users_path(id: one_user.id)
      expect(page).to have_content(one_user.fullname)
    end
  end

  describe '/users?staus=:status' do
    it 'status filter works' do
      sully = users(:sully)
      sully.status_id = 1 # valid
      sully.save

      mike = users(:mike2)
      mike.status_id = 2 # invalid
      mike.save

      visit '/users?status=1'
      expect(page).to have_content(sully.email)
      expect(page).to_not have_content(mike.email)

      visit '/users?status=2'
      expect(page).to have_content(mike.email)
      expect(page).to_not have_content(sully.email)

      visit '/users'
      expect(page).to have_content(mike.email)
      expect(page).to have_content(sully.email)

      visit '/users?status=0'
      expect(page).to have_content(mike.email)
      expect(page).to have_content(sully.email)
    end
  end
end
