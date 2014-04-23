require 'spec_helper'

feature 'User access admin' do
  background do
    user = create(:user)
    login_with_email(user)
  end

  scenario 'is redirected to root if not admin', feature: true do
    visit admin_root_path
    expect(current_path).to eql(root_path)
  end

  scenario 'is redirected to dashboard if admin', feature: true do
    user = create(:user, :admin)
    login_with_email(user)

    visit admin_root_path
    expect(current_path).to eql(admin_root_path)
  end

end
