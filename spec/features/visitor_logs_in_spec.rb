require 'spec_helper'

feature 'Visitor logs in' do
  background do
    create(:user, :member, :email => 'valid@example.com', :password => 'password', :nickname => 'valid.user')
  end

  scenario 'with valid email and password' do
    login_with 'valid@example.com', 'password'

    expect(page).to have_content('Log out')
    expect(current_path).to eq(root_path)
  end

  scenario 'with valid nickname and password' do
    login_with_nickname 'valid.user', 'password'

    expect(page).to have_content('Log out')
    expect(current_path).to eq(root_path)
  end

  scenario 'with invalid email' do
    login_with 'invalid@example.com', 'password'

    expect(page).to have_content('Log in')
    expect(current_path).to eq(sessions_path)
  end

  scenario 'with invalid nickname' do
    login_with 'invalid.user', 'password'

    expect(page).to have_content('Log in')
    expect(current_path).to eq(sessions_path)
  end

  scenario 'with invalid password' do
    login_with 'valid@example.com', 'drowssap'

    expect(page).to have_content('Log in')
    expect(current_path).to eq(sessions_path)
  end

  scenario 'and can sign up on the same page' do
    visit login_path

    expect(page).to have_content('Sign up')
  end

  scenario 'and can reset password on the same page' do
    visit login_path

    expect(page).to have_content('Reset password')
  end
end