require 'spec_helper'

describe Comment do
  it 'belongs to article', :focus => true do
    a = create(:article)
    c = create(:comment)
    a.comments << c
    a.save

    expect(a.comments.size).to eq(1)
    expect(Comment.count).to eq(1)
  end
end
