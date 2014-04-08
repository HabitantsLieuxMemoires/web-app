require 'spec_helper'

feature 'User create articles' do

  background do
    user = create(:user)
    login_with_email(user)
  end

  scenario 'with valid title and content' do
    article = build(:article)
    create_article(article)
    expect(page).to have_content(I18n.t('models.article.created'))
  end

  scenario 'with invalid data' do
    article = build(:article, title: 'rt')
    create_article(article)
    expect(page).to have_content(I18n.t('models.article.creation_error'))
    expect(current_path).to eq(articles_path)
  end

  scenario 'from home page' do
    visit root_path
    click_on I18n.t('models.article.create')
    expect(current_path).to eql(new_article_path)
  end

end
