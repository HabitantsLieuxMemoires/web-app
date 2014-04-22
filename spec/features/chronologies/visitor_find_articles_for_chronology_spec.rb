require 'spec_helper'

feature 'Visitor find articles for chronology' do

  scenario 'from home page' do
    chronology = create(:chronology)

    visit root_path
    within '#sidebar-chronologies' do
      chronologies = all('ul li a')
      expect(chronologies.size).to eq(1)

      chronologies.first.click
    end

    expect(current_path).to eql(chronology_path(chronology.id))
  end

end
