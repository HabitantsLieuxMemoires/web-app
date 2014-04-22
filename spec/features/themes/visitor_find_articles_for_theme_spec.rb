require 'spec_helper'

feature 'Visitor find articles for theme' do

  scenario 'from home page' do
    theme = create(:theme)

    visit root_path
    within '#sidebar-themes' do
      themes = all('ul li a')
      expect(themes.size).to eq(1)

      themes.first.click
    end

    expect(current_path).to eql(theme_path(theme.id))
  end

end
