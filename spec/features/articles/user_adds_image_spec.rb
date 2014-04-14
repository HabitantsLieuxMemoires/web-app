require 'spec_helper'

feature 'User adds image' do

  background do
    user = create(:user)
    login_with_email(user)

    @article = create(:article)
  end

  scenario 'with valid image', :focus => true do
    file = fixture_file_upload('spec/files/test_image.gif', 'image/gif')
    visit edit_article_path(@article.id)

    click_on 'show_images'
    attach_file 'article_image', file
  end

  scenario 'with image too big', :focus => true do
    pending
  end

  scenario 'with another file type', :focus => true do
    pending
  end

end
