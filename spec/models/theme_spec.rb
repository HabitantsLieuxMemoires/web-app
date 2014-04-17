require 'spec_helper'

describe Theme do
  describe 'contains validators' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).within(6..50) }
    it { should have_many(:articles) }
  end

  it 'is invalid with a duplicate title' do
    t1 = create(:theme)
    t2 = build(:theme, :title => t1.title)
    expect(t2).to_not be_valid
  end
end
