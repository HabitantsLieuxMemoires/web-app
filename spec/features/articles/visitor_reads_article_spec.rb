require 'spec_helper'

feature 'Visitor reads article' do
  background do
    @article = create(:article)
  end

  scenario 'which exist' do
    visit article_path(@article.id)
    expect(page).to have_content(@article.title)
  end

  scenario 'wich does not exist' do
    visit article_path('no-result-id')
    expect(page).to have_content(I18n.t('models.article.not_found'))
  end
end
