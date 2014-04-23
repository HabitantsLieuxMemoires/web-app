require 'spec_helper'

feature 'Visitor access admin' do

  scenario 'is redirected to login' do
    visit admin_root_path
    expect(current_path).to eql(login_path)
  end

end
