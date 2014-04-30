require 'spec_helper'

feature 'User reads article' do
  background do
    user = create(:user)
    login_with_email(user)
    @article = create(:article)
  end

  scenario 'and can create comment', :js => true do
    visit article_path(@article)

    expect(page).to have_css('#create_comment')
  end

  scenario 'and cannot add image', js: true do
    visit article_path(@article)
    click_on 'show_images'

    within '#images' do
      expect(page).not_to have_content(I18n.t('models.image.upload'))
    end
  end

  scenario 'and cannot add video', js: true do
    visit article_path(@article)
    click_on 'show_videos'

    within '#videos' do
      expect(page).not_to have_content(I18n.t('models.video.add'))
    end
  end

end
