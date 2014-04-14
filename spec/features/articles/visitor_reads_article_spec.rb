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

  scenario 'and can see comments', :js => true, :focus => true do
    comment = create(:comment)
    @article.comments << comment
    @article.save

    visit article_path(@article)
    click_on 'show_comments'

    within('#comments-list') do
      expect(page.all('.comment').size).to eq(1)
    end
  end

  scenario 'and cannot create comment' do
    visit article_path(@article)

    expect(page).not_to have_css('#create_comment')
  end
end
