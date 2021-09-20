require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_user) do
    {
      id: 1,
      first_name: "Mike",
      last_name: "Wazowski",
      email: 'mike@monstersinc.com' ,
      status_id: 1, # status are seeded.
    }
  end

  it { should belong_to(:user_status) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:email) }

  it 'is valid with with valid attributes' do
    new_user = User.new(valid_user)
    expect(new_user).to be_valid
  end

  it 'is not valid without email' do
    new_user = User.new(valid_user)
    new_user.email = nil
    expect(new_user).to_not be_valid
  end

  it 'is not valid without name' do
    new_user = User.new(valid_user)
    new_user.first_name = nil
    expect(new_user).to_not be_valid
  end

  it 'was downcased before save' do
    new_user = User.new(valid_user)
    new_user.email = 'MIkeGuas25@Gmail.cOm'
    new_user.save
    expect(new_user.email).to eq(new_user.email.downcase)
  end

  it 'is not valid when email regex is not valid' do
    new_user = User.new(valid_user)
    new_user.email = 'emailnovalido.com'
    expect(new_user).to_not be_valid
    new_user.email = 'emailnovalido@'
    expect(new_user).to_not be_valid
  end

  it 'is not valid with email length > 255' do
    new_user = User.new(valid_user)
    new_user.email = ('a' * 246) + '@gmail.com'
    expect(new_user).to_not be_valid
  end

  it 'is not valid when email is duplicated' do
    User.create(valid_user)
    new_user = User.new(valid_user)
    expect(new_user).to_not be_valid
  end
end
