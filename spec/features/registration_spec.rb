require 'rails_helper'

=begin
As a visitor ****(not logged in)****
When I visit '/'
and I can click a link that says "Sign Up to Be a User"
and I can enter registration details in a form
and submit that form
Then I should see a welcome message with my username
and my user details have been saved in the database.

=end

describe 'registrational workflow' do
  it 'submits a registration successfully' do
    username = 'pumped_to_be_here'

    visit root_path

    click_on 'Sign Up to be a New User'

    expect(current_path).to eq(new_user_path)

    fill_in :user_username, with: username
    fill_in :user_password, with: '12345'

    click_on 'Create User'

    expect(current_path).to eq(user_path(User.last))
    expect(page).to have_content("Welcome, #{username}!")
  end
end

describe 'registrational workflow' do
  it 'submits a registration form with duplicate username' do
    username = 'pumped_to_be_here'
    User.create(username: username, password: 'blakjdbal')
    count = User.count

    visit '/'

    click_on 'Sign Up to be a New User'

    expect(current_path).to eq(new_user_path)

    fill_in :user_username, with: username
    fill_in :user_password, with: '12345'

    click_on 'Create User'

    expect(current_path).to eq(users_path)
    expect(User.count). to eq(count)
  end
end
