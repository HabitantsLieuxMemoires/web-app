require 'spec_helper'

feature 'User reads article' do
  background do
    user = create(:user)
    login_with_email(user)
    @article = create(:article)
  end

  scenario 'and can create comment', :js => true do
    visit article_path(@article)
    click_on 'show_comments'

    expect(page).to have_css('#create_comment')
  end

  scenario 'and cannot add image', :js => true do
    visit article_path(@article)
    click_on 'show_images'

    expect(page).not_to have_css('#add_image')
  end
end
