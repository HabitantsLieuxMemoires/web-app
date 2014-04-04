require 'spec_helper'

feature 'User changes password' do

  scenario 'updates the user password when confirmation matches' do
    user = create(:user, :reset_password_token => "something")
    visit edit_password_reset_path(user.reset_password_token)
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Update password"
    expect(page).to have_content("Password was successfully updated")
    expect(current_path).to eq(root_path)
  end

  scenario 'does not update the user password when confirmation does not match' do
    user = create(:user, :reset_password_token => "something")
    visit edit_password_reset_path(user.reset_password_token)
    fill_in "Password", with: "password"
    click_button "Update password"
    expect(page).to have_content("Password confirmation doesn't match")
  end

  scenario 'redirect to login when token is invalid' do
    user = create(:user, :reset_password_token => "something", :reset_password_token_expires_at => Date.today.prev_day)
    visit edit_password_reset_path(user.reset_password_token)
    expect(current_path).to eq(login_path)
  end

  scenario 'redirect to login when token is invalid' do
    visit edit_password_reset_path("something_else")
    expect(current_path).to eq(login_path)
  end
end