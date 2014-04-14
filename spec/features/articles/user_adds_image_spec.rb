require 'spec_helper'

feature 'Users add image' do

  background do
    user = create(:user)
    login_with_email(user)
  end

  scenario 'with valid image', :focus => true do
    a = create(:article)
    visit edit_article_path(a.id)
    click_on 'show_images'
    click_on 'add_image'
  end

  scenario 'with image to big', :focus => true do
    pending
  end

end
