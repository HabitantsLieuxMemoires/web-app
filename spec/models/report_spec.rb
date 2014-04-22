require 'spec_helper'

describe Report do
  describe 'contains validators' do
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).within(4..1024) }
    it { should belong_to(:article) }
    it { should belong_to(:user) }
  end
end
