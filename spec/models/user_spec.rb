require 'spec_helper'

#TODO: Find a way to role field (actually mongoid-rspec does not support Mongoid::Enum module)
describe User do

  describe "contains validators" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_confirmation_of(:password) }
    it { should validate_length_of(:password).within(8..50) }
    it { should be_timestamped_document.with(:created) }
    it { should validate_presence_of(:nickname) }
    it { should validate_length_of(:nickname).within(4..50) }
    it { should validate_uniqueness_of(:nickname) }
  end

  it "is valid with nickname, email and password confirmation" do
    u = build(:user, :member)
    expect(u).to be_valid
  end

  it "is invalid without email" do
    u = build(:user, :member, :email=> nil)
    expect(u).to_not be_valid
  end

  it "is invalid without nickname" do
    u = build(:user, :member, :nickname=> nil)
    expect(u).to_not be_valid
  end

  it "is invalid if passwords don't match" do
    u = build(:user, :member, :password => "password1", :password_confirmation => "1drowssap")
    expect(u).to_not be_valid
  end

  it "is invalid with a duplicate email address" do
    create(:user, :member)
    u = build(:user, :member, :nickname => "other.nickname")
    expect(u).to_not be_valid
  end

  it "is invalid with a duplicate nickname" do
    create(:user, :member)
    u = build(:user, :member, :email => "other@exmaple.com")
    expect(u).to_not be_valid
  end

end
