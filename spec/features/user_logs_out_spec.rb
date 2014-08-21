require 'spec_helper'

feature 'User logs out' do

  scenario 'while connected' do
    user = create(:user)
    login_with_email user
    expect(page).to have_content(I18n.t('logout').upcase)

    logout
    expect(page).to have_content(I18n.t('login').upcase)
    expect(current_path).to eq(root_path)
  end
end
