require 'spec_helper'

feature 'User edits article' do
  background do
    user = create(:user)
    login_with_email(user)

    @article = create(:article)
  end

  scenario 'with valid data', :focus => true do
    visit edit_article_path(@article.id)
    fill_in 'article[title]', with: 'New Title'
    click_on I18n.t('publish')

    expect(page).to have_content(I18n.t('models.article.updated'))
    expect(page).to have_content('New Title')
  end

  scenario 'with invalid data', :focus => true do
    visit edit_article_path(@article.id)
    fill_in 'article[title]', with: ''
    click_on I18n.t('publish')

    expect(page).to have_content(I18n.t('models.article.update_error'))
  end

end
