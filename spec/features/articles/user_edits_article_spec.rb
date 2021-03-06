require 'spec_helper'

feature 'User edits article' do
  background do
    user = create(:user)
    login_with_email(user)

    @article = create(:article)
  end

  scenario 'with valid data' do
    visit edit_article_path(@article.id)
    fill_in 'article[title]', with: 'New Title'
    click_on I18n.t('publish')

    expect(page).to have_content(I18n.t('models.article.updated'))
    expect(page).to have_content('New Title')
  end

  scenario 'with invalid data' do
    visit edit_article_path(@article.id)
    fill_in 'article[title]', with: ''
    click_on I18n.t('publish')

    expect(page).to have_content(I18n.t('models.article.update_error'))
  end

  scenario 'and cannot add comment' do
    visit edit_article_path(@article.id)

    expect(page).not_to have_content(I18n.t('models.comment.create'))
  end

  scenario 'and can add image', js: true do
    visit edit_article_path(@article.id)
    click_on 'show_images'

    within '#images' do
      expect(page).to have_content(I18n.t('models.image.upload'))
    end
  end

  scenario 'and can update theme' do
    article = create(:article)
    theme = create(:theme)

    visit edit_article_path(article.id)
    select theme.title, from: 'article[theme_id]'
    click_button I18n.t('publish')

    expect(page).to have_content(theme.title)
  end

  scenario 'and can update chronology' do
    article = create(:article)
    chronology = create(:chronology)

    visit edit_article_path(article.id)
    select chronology.title, from: 'article[chronology_id]'
    click_button I18n.t('publish')

    expect(page).to have_content(chronology.title)
  end

  scenario 'and can add video', js: true do
    visit article_path(@article)
    click_on 'show_videos'

    within '#videos' do
      expect(page).to have_content(I18n.t('models.video.add'))
    end
  end

end
