require 'spec_helper'

describe Video do
  describe 'contains validators' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).within(4..80) }
    it { should validate_presence_of(:url) }
    it { should validate_length_of(:url).within(16..256) }
    it { should be_embedded_in(:article) }
  end

  it 'belongs to article' do
    a = create(:article)
    v = build(:video)
    a.videos << v
    a.save

    expect(a.videos.size).to eq(1)
  end

  it 'is valid with youtube url' do
    v = build(:video, url: 'https://www.youtube.com/watch?v=cUsOjj8m02o')
    expect(v).to be_valid
  end

  it 'is not valid with dailymotion url' do
    v = build(:video, url: 'http://www.dailymotion.com/video/x19yi1m_bill-murray-talks-about-quiet-heroism-and-art_people')
    expect(v).to be_valid
  end

  it 'is valid with vimeo url' do
    v = build(:video, url: 'http://vimeo.com/63303557')
    expect(v).to be_valid
  end

  it 'is invalid with other url' do
    v = build(:video, url: Faker::Internet.url)
    expect(v).not_to be_valid
  end
end
