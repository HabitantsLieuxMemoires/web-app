require 'spec_helper'

feature 'Visitor signs up' do
  scenario 'with valid email, nickname and password' do
    sign_up_with 'valid@example.com', 'valid.user', 'password'

    expect(page).to have_content('Log out')
    expect(current_path).to eq(root_path)
  end

  scenario 'with invalid email' do
    sign_up_with 'invalid_email', 'valid.user', 'password'

    expect(page).to have_content('Sign up')
    expect(current_path).to eq(users_path)
  end

  scenario 'with nil nickname' do
    sign_up_with 'valid@example.com', nil, 'pass'

    expect(page).to have_content('Sign up')
    expect(current_path).to eq(users_path)
  end

  scenario 'with invalid password' do
    sign_up_with 'valid@example.com', 'valid.user', 'pass'

    expect(page).to have_content('Sign up')
    expect(current_path).to eq(users_path)
  end
end