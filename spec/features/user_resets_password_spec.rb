require 'spec_helper'

feature 'User resets password' do
  background do
    @user = create(:user)
    ActionMailer::Base.deliveries.clear
  end

  scenario 'emails user when requesting password reset with valid email' do
    reset_password_with(@user.email)

    expect(page).to have_content(I18n.t('password.reset_instructions_sent'))
    expect(ActionMailer::Base.deliveries.last.to).to eq([@user.email])
    expect(current_path).to eq(root_path)
  end

  scenario 'emails user when requesting password reset with valid nickname' do
    reset_password_with(@user.nickname)

    expect(page).to have_content(I18n.t('password.reset_instructions_sent'))
    expect(ActionMailer::Base.deliveries.last.to).to eq([@user.email])
    expect(current_path).to eq(root_path)
  end

  scenario 'does not email invalid user when requesting password reset' do
    reset_password_with('nonexisting@hlm.fr')

    expect(page).to have_content(I18n.t('password.reset_instructions_sent'))
    expect(ActionMailer::Base.deliveries.size).to eq(0)
    expect(current_path).to eq(root_path)
  end
end