# == Schema Information
#
# Table name: friends
#
#  id         :integer          not null, primary key
#  account_id :integer          not null
#  friend_id  :integer          not null
#  approved   :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Friend do

  let(:user)        { FactoryGirl.create(:user) }
  let(:friend_user) { FactoryGirl.create(:user, username: 'Other User', email_address: 'blah@example.com') }
  let(:account)        { user.create_account(birthday: '1980-01-01') }
  let(:friend_account) { friend_user.create_account(birthday: '1974-05-03') }
  let(:relationship) { account.relationships.build(friend_id: friend_account.id, approved: 1) }

  subject { relationship }

  it { should respond_to(:approved)  }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to account_id" do
      expect do
        Friend.new(account_id: account.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "friend methods" do
    it { should respond_to(:account_id) }
    it { should respond_to(:friend_id)  }

    its(:account) { should == account }
    its(:friend)  { should == friend_account }
  end

  describe "when account id is missing" do
    before { relationship.account_id = nil }
    it { should_not be_valid }
  end

  describe "when friend id is missing" do
    before { relationship.friend_id = nil }
    it { should_not be_valid }
  end
end
