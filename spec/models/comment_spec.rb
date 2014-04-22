require 'spec_helper'

describe Comment do
  describe 'contains validators' do
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).within(4..1024) }
    it { should belong_to(:article) }
  end

  it 'belongs to article' do
    a = create(:article)
    c = create(:comment)
    a.comments << c
    a.save

    expect(a.comments.size).to eq(1)
    expect(Comment.count).to eq(1)
  end
end
