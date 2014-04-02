require 'spec_helper'

feature 'Visitor signs up' do
  scenario 'with valid email and password' do
    sign_up_with 'valid@example.com', 'password'

    expect(page).to have_content('Log out')
  end

  scenario 'with invalid email' do
    sign_up_with 'invalid_email', 'password'

    expect(page).to have_content('Sign up')
  end

  scenario 'with invalid password' do
    sign_up_with 'valid@example.com', 'pass'

    expect(page).to have_content('Sign up')
  end
end