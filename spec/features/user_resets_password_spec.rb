require 'spec_helper'

feature 'User resets password' do
  background do
    create(:user, :email => 'valid@example.com', :nickname => 'nickname.test')
    ActionMailer::Base.deliveries.clear
  end

  scenario 'emails user when requesting password reset with valid email' do
    reset_password_with('valid@example.com')

    expect(ActionMailer::Base.deliveries.last.to).to eq(['valid@example.com'])
    expect(current_path).to eq(root_path)
  end

  scenario 'emails user when requesting password reset with valid nickname' do
    reset_password_with('nickname.test')

    expect(ActionMailer::Base.deliveries.last.to).to eq(['valid@example.com'])
    expect(current_path).to eq(root_path)
  end

  scenario 'does not email invalid user when requesting password reset' do
    reset_password_with('invalid@example.com')

    expect(ActionMailer::Base.deliveries.size).to eq(0)
    expect(current_path).to eq(root_path)
  end
end