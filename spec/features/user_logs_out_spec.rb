require 'spec_helper'

feature 'User logs out' do
  background do
    create(:user, :member, :email => 'valid@example.com', :password => 'password')
  end

  scenario 'while connected' do
    login_with 'valid@example.com', 'password'
    expect(page).to have_content('Log out')

    logout
    expect(page).to have_content('Log in')
  end
end