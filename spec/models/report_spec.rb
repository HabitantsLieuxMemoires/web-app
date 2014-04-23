require 'spec_helper'

describe Report do
  describe 'contains validators' do
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).within(4..1024) }
    it { should belong_to(:article) }
    it { should belong_to(:user) }
    it { should validate_presence_of(:state) }
    it { should validate_inclusion_of(:state).to_allow(Report::STATES.values) }
  end

  it 'should be valid with existing state' do
    r = build(:report, state: Report::STATES[:addressed])
    expect(r).to be_valid
  end

  it 'should not be valid with unexisting state' do
    r = build(:report, state: 'unknown')
    expect(r).not_to be_valid
  end
end
