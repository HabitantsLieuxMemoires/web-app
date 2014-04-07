require 'spec_helper'

feature 'User create articles' do

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

end
