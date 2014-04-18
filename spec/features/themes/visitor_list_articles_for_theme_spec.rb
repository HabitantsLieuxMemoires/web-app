require 'spec_helper'

feature 'Visitor list articles for theme' do

  scenario 'with no article' do
    theme = create(:theme)
    visit theme_path(theme.id)

    expect(page).not_to have_css('.media-list')
  end

  scenario 'with articles' do
    theme = create(:theme)
    create_list(:article, 10, theme: theme)

    visit theme_path(theme.id)

    within '#theme-articles' do
      expect(all('li').size).to eq(10)
    end
  end

end
