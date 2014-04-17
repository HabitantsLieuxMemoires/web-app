require 'spec_helper'

describe Chronology do
  describe 'contains validators' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).within(3..20) }
    it { should have_many(:articles) }
  end

  it 'is invalid with a duplicate title' do
    c1 = create(:chronology)
    c2 = build(:chronology, :title => c1.title)
    expect(c2).to_not be_valid
  end
end
