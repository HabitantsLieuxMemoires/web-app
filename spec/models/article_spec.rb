require 'spec_helper'

describe Article do
  describe 'contains validators' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
    it { should be_timestamped_document }
    it { should validate_length_of(:title).within(4..80) }
    it { should have_many(:images).with_autosave }
    it { should have_many(:comments) }
    it { should have_many(:reports) }
    it { should belong_to(:theme) }
    it { should belong_to(:chronology) }
  end

  it 'is valid with tags' do
    a = build(:article)
    a.tags_array = Faker::Lorem.words(3)
    expect(a).to be_valid
    expect(a.tags_array.size).to eq(3)
  end

  it 'is valid with location' do
    a = build(:article, :with_location)
    expect(a).to be_valid
  end

  it 'is valid with theme' do
    a = build(:article)
    a.theme = build(:theme)
    expect(a).to be_valid
  end

  it 'is valid with chronology' do
    a = build(:article)
    a.chronology = build(:chronology)
    expect(a).to be_valid
  end

  it 'is tracked when created' do
    a = create(:article)

    expect(a.history_tracks.count).to eq(1)
  end

  it 'is tracked when title updated' do
    a = create(:article)
    a.update_attributes(title: 'New title')

    expect(a.history_tracks.count).to eq(2)
  end

  it 'is tracked when body updated' do
    a = create(:article)
    a.update_attributes(body: 'New Body')

    expect(a.history_tracks.count).to eq(2)
  end

end
