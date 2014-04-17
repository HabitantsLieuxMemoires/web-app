require 'spec_helper'

describe Article do
  describe 'contains validators' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
    it { should be_timestamped_document }
    it { should validate_length_of(:title).within(4..80) }
    it { should have_many(:images).with_autosave }
    it { should have_many(:comments).with_autosave }
    it { should belong_to(:theme) }
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
    # Article must be saved as location is updated using :before_save callback
    a.save!
    expect(a.location).not_to be_empty
  end

  it 'is valid with theme' do
    a = build(:article)
    a.theme = build(:theme)
    expect(a).to be_valid
  end
end
