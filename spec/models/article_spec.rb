require 'spec_helper'

describe Article do
  describe 'contains validators' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
    it { should be_timestamped_document }
    it { should validate_length_of(:title).within(4..80) }
  end

  it 'is valid with tags' do
    a = build(:article)
    a.tags_array = Faker::Lorem.words(3)
    expect(a).to be_valid
    expect(a.tags_array.size).to eq(3)
  end
end
