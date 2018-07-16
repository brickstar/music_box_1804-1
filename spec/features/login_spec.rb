require 'rails_helper'

=begin

As a registered user
When I visit '/'
and I click on a link that says "I already have an account"
Then I should see a login form
and I can enter my username and password
and submit the form
and see a welcome message with my username
and my user ID is stored in a session
and I should no longer see the link that says "I already have an account"
and I should see a link that says "Log out"

=end

describe 'login workflow' do
  it 'allows registered users to login successfully' do
    user = User.create(username: 'Pearl', password: 'test')

    visit root_path

    click_on 'I already have an account'

    expect(current_path).to eq(login_path)

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_on 'Login'

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("Logout")
  end

  it 'allows registered users to logout succesufully' do
    user = User.create(username: 'Pearl', password: 'test')

    visit root_path

    click_on 'I already have an account'

    expect(current_path).to eq(login_path)

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_on 'Login'

    click_on 'Logout'

    expect(current_path).to eq(root_path)
    expect(page).to have_button('I already have an account')
  end
end
