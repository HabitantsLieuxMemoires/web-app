require 'spec_helper'

feature 'Visitor lists articles for chronology' do

  scenario 'with no article' do
    chronology = create(:chronology)
    visit chronology_path(chronology.id)

    expect(page).not_to have_css('.articles')
  end

  scenario 'with articles and no pagination' do
    chronology = create(:chronology)
    create_list(:article, 10, chronology: chronology)

    visit chronology_path(chronology.id)

    within '#chronology-articles' do
      expect(all('.article').size).to eq(10)
    end
  end

  scenario 'with articles and pagination' do
    chronology = create(:chronology)
    create_list(:article, 15, chronology: chronology)

    visit chronology_path(chronology.id)

    within '#chronology-articles' do
      expect(all('.article').size).to eq(10)
    end

    page.find('.next_page a').click

    within '#chronology-articles' do
      expect(all('.article').size).to eq(5)
    end
  end

end
