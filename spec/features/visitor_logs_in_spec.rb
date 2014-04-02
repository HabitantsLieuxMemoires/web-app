require 'spec_helper'

feature 'Visitor logs in' do
  background do
    create(:user, :member, :email => 'valid@example.com', :password => 'password')
  end

  scenario 'with valid email and password' do
    login_with 'valid@example.com', 'password'

    expect(page).to have_content('Log out')
  end

  scenario 'with invalid password' do
    login_with 'valid@example.com', 'drowssap'

    expect(page).to have_content('Log in')
  end
end