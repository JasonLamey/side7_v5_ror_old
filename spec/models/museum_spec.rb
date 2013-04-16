require 'spec_helper'

describe Museum do

  let(:user)       { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user, username: "Bar", email_address: "bar@example.com") }
  let(:watcher) { user.create_account(birthday: "1980-03-30") }
  let(:watched) { other_user.create_account(birthday: "1967-11-21") }
  let(:museum) { watcher.museums.build(watched_id: watched.id) }

  subject { museum }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to watcher_id" do
      expect do
        Museum.new(watcher_id: watcher.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when watched id is not present" do
    before { museum.watched_id = nil }
    it { should_not be_valid }
  end

  describe "when watcher id is not present" do
    before { museum.watcher_id = nil }
    it { should_not be_valid }
  end
end
