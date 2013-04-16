# == Schema Information
#
# Table name: user_links
#
#  id             :integer          not null, primary key
#  account_id     :integer          not null
#  name           :string(255)      not null
#  url            :string(255)      not null
#  nsfw           :integer          default(0), not null
#  sort_order     :integer
#  click_throughs :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe UserLink do

  let(:user) { FactoryGirl.create(:user) }
  let(:account) { FactoryGirl.create(:account, user_id: user.id) }
  before do  
    @user_link = account.user_links.create(name: "Example Link", 
                                           url: "http://www.example.com", 
                                           nsfw: 0, sort_order: 1)
  end

  subject { @user_link }

  it { should respond_to(:name)           }
  it { should respond_to(:url)            }
  it { should respond_to(:nsfw)           }
  it { should respond_to(:sort_order)     }
  it { should respond_to(:click_throughs) }
  it { should respond_to(:account_id)     }
  it { should respond_to(:account)        }

  its(:account) { should == account }

  it { should be_valid }

  describe "if account_id is missing" do
    before { @user_link.account_id = nil }
    it { should_not be_valid }
  end

  describe "if name is missing" do
    before { @user_link.name = nil }
    it { should_not be_valid }
  end

  describe "if url is missing" do
    before { @user_link.url = nil }
    it { should_not be_valid }
  end

  describe "if nsfw is missing" do
    before { @user_link.nsfw = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to account_id" do
      expect do
        UserLink.new(account_id: account.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end
