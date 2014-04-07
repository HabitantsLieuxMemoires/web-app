require 'spec_helper'

feature 'Visitor signs up' do
  scenario 'create account with valid email, nickname and password' do
    user = build(:user)
    sign_up_with user

    expect(page).to have_content(I18n.t('signed_up'))
    expect(current_path).to eq(root_path)
  end

  scenario 'does not create account with invalid email' do
    user = build(:user, email: 'invalid_email.fr')
    sign_up_with user

    expect(page).to have_content('wrong email address')
    expect(current_path).to eq(users_path)
  end

  scenario 'does not create account with nil nickname' do
    user = build(:user, nickname: nil)
    sign_up_with user

    expect(page).to have_content('Nickname can\'t be blank')
    expect(current_path).to eq(users_path)
  end

  scenario 'does not create account with invalid password' do
    user = build(:user, password: 'short')
    sign_up_with user

    expect(page).to have_content('Password is too short')
    expect(current_path).to eq(users_path)
  end

  scenario 'does not create account with duplicated email' do
    create(:user)
    user = build(:user, nickname: 'another.nickname')

    sign_up_with user
    expect(page).to have_content('Email is already taken')
    expect(current_path).to eq(users_path)
  end

  scenario 'does not create account with duplicated nickname' do
    create(:user)
    user = build(:user, email: 'another@hlm.fr')

    sign_up_with user
    expect(page).to have_content('Nickname is already taken')
    expect(current_path).to eq(users_path)
  end
end