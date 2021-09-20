require 'rails_helper'

RSpec.describe 'Users actions', type: :feature do
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
      puts user
      expect(page).to have_content user.first_name
      expect(page).to have_content user.last_name
    end
  end

  describe '/users/:id' do
    before do
      User.create(user_valid)
      visit '/users/1'
    end

    it 'finds user name on the page' do
      user = User.find(1)
      expect(page).to have_content(user.fullname)
    end
  end
end
