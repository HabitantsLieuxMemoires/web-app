require 'spec_helper'

feature 'Visitor searches articles' do

  scenario 'from autocomplete field', js: true, pending: true do
    pending 'Find a way to make typeahead autocomplete working'
    # a = create(:article, title: 'Test')

    # visit root_path

    # within '#sidebar-actions' do
    #   fill_autocomplete('search-article', with: 'Test')
    #   suggestions = all('.twitter-typeahead .tt-dropdown-menu .tt-dataset-articles')

    #   expect(suggestions.size).to eq(1)
    # end
  end

  def fill_autocomplete(field, options = {})
    fill_in field, with: options[:with]

    page.execute_script %Q{ $('##{field}').trigger('focus') }
    page.execute_script %Q{ $('##{field}').trigger('keydown') }
  end

end
