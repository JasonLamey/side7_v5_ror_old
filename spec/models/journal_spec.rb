# == Schema Information
#
# Table name: journals
#
#  id             :integer          not null, primary key
#  account_id     :integer          not null
#  title          :string(255)
#  body           :text             default(""), not null
#  privacy        :enum([:public, : default(:public)
#  allow_comments :enum([:anyone, : default(:anyone)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe Journal do
  let(:user) { FactoryGirl.create(:user) }
  let(:account) { FactoryGirl.create(:account, user_id: user.id) }
  before { @journal = account.journals.build(title: "example title", body: "Example Body. Big body.") }

  subject{ @journal }

  it { should respond_to(:title)          }
  it { should respond_to(:body)           }
  it { should respond_to(:privacy)        }
  it { should respond_to(:allow_comments) }
  it { should respond_to(:account_id)     }
  it { should respond_to(:account)        }

  its(:account) { should == account }

  it { should be_valid }

  describe "when account_id is missing" do
    before { @journal.account_id = nil }
    it { should_not be_valid }
  end

  describe "when body is missing" do
    before { @journal.body = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to account_id" do
      expect do
        Journal.new(account_id: account.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end
