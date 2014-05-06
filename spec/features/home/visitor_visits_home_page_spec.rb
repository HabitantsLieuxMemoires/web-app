require 'spec_helper'

feature 'Visitor visits home page' do

  scenario 'and can see top themes' do
    theme = create(:theme)

    visit root_path
    within '#sidebar-themes' do
      themes = all('.theme')
      expect(themes.size).to eq(1)
    end
  end

  scenario 'and can see top chronologies' do
    chronology = create(:chronology)

    visit root_path
    within '#sidebar-chronologies' do
      chronologies = all('.chronology')
      expect(chronologies.size).to eq(1)
    end
  end

  scenario 'and can see newest articles' do
    article = create(:article)

    visit root_path
    within '#sidebar-news' do
      articles = all('.new')

      expect(articles.size).to eq(1)
    end
  end

  scenario 'and can see featured articles' do
    f = create(:feature_with_articles, articles_count: 5)

    visit root_path
    within '#main-featured' do
      articles = all('.feature')

      expect(articles.size).to eq(5)
    end
  end

end
