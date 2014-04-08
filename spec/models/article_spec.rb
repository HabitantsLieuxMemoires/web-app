require 'spec_helper'

describe Article do
  describe 'contains validators' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
    it { should be_timestamped_document }
    it { should validate_length_of(:title).within(4..80) }
  end
end
