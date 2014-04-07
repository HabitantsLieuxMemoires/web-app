require 'spec_helper'

feature 'Visitor logs in' do
  background do
    @user = create(:user)
  end

  scenario 'successfully with valid email and password' do
    login_with_email @user

    expect(page).to have_content('Logged in')
    expect(current_path).to eq(root_path)
  end

  scenario 'successfully with valid nickname and password' do
    login_with_nickname  @user

    expect(page).to have_content('Logged in')
    expect(current_path).to eq(root_path)
  end

  scenario 'unsuccessfully with invalid email' do
    user = build(:user, email: 'nonexisting@hlm.fr')
    login_with_email user

    expect(page).to have_content('Log in')
    expect(current_path).to eq(sessions_path)
  end

  scenario 'unsuccessfully with invalid nickname' do
    user = build(:user, nickname: 'nonexisting.hlm')
    login_with_nickname user

    expect(page).to have_content('Log in')
    expect(current_path).to eq(sessions_path)
  end

  scenario 'unsuccessfully with invalid password' do
    user = build(:user, password: 'drowssap')
    login_with_email user

    expect(page).to have_content('Log in')
    expect(current_path).to eq(sessions_path)
  end

  scenario 'and can sign up on the same page' do
    visit login_path

    expect(page).to have_content(I18n.t('signup'))
  end

  scenario 'and can reset password on the same page' do
    visit login_path

    expect(page).to have_content(I18n.t('password.reset'))
  end
end