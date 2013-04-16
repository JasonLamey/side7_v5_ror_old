require 'spec_helper'

describe UserPreference do

  let(:user) { FactoryGirl.create(:user) }
  let(:account) { user.create_account(birthday: "1973-01-15") }
  let(:user_preference) { account.create_user_preference() }

  subject { user_preference }

  it { should be_valid }

  describe "missing attributes" do
    describe "when account_id is missing" do
      before { user_preference.account_id = nil }
      it { should_not be_valid }
    end
    describe "when allow_email_through_forms is missing" do
      before { user_preference.allow_email_through_forms = nil }
      it { should_not be_valid }
    end
    describe "when allow_favoriting is missing" do
      before { user_preference.allow_favoriting = nil }
      it { should_not be_valid }
    end
    describe "when allow_pms is missing" do
      before { user_preference.allow_pms = nil }
      it { should_not be_valid }
    end
    describe "when allow_watching is missing" do
      before { user_preference.allow_watching = nil }
      it { should_not be_valid }
    end
    describe "when comment_notifications is missing" do
      before { user_preference.comment_notifications = nil }
      it { should_not be_valid }
    end
    describe "when display_signature is missing" do
      before { user_preference.display_signature = nil }
      it { should_not be_valid }
    end
    describe "when pms_notifications is missing" do
      before { user_preference.pms_notifications = nil }
      it { should_not be_valid }
    end
    describe "when show_adult_content is missing" do
      before { user_preference.show_adult_content = nil }
      it { should_not be_valid }
    end
    describe "when show_m_thumbs is missing" do
      before { user_preference.show_m_thumbs = nil }
      it { should_not be_valid }
    end
    describe "when show_management_thumbs is missing" do
      before { user_preference.show_management_thumbs = nil }
      it { should_not be_valid }
    end
    describe "when show_online is missing" do
      before { user_preference.show_online = nil }
      it { should_not be_valid }
    end
  end

  describe "accessible attributes" do
    it "should not allow access to account_id" do
      expect do
        UserPreference.new(account_id: account.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end
