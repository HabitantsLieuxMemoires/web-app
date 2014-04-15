require 'spec_helper'

describe Image do
  describe 'contains validators' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).within(4..80) }
  end

  it 'belongs to article' do
    a = create(:article)
    i = create(:image)
    a.images << i
    a.save

    expect(a.images.size).to eq(1)
    expect(Image.count).to eq(1)
  end

  it 'is valid with image of good size' do
    i = build(:image)
    expect(i).to be_valid
  end

  it 'is not valid with image too big' do
    i = build(:image, :too_big)
    expect(i).not_to be_valid
  end
end
