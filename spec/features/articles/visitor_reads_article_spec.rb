require 'spec_helper'

feature 'Visitor reads article' do
  background do
    @article = create(:article)
  end

  scenario 'which exist' do
    visit article_path(@article)
    expect(current_path).to eql(article_path(@article.id))
  end

  scenario 'wich does not exist' do
    expect {
      visit article_path('no-result-id')
    }.to raise_error(Mongoid::Errors::DocumentNotFound)
  end
end
