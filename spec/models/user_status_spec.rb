# == Schema Information
#
# Table name: user_statuses
#
#  id          :integer          not null, primary key
#  user_status :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe UserStatus do
  before { @user_status = UserStatus.new(user_status: 'Test') }

  subject { @user_status }

  it { should respond_to(:user_status) }
  it { should respond_to(:account)     }

  it { should be_valid }

  describe "when user_status is not present" do
    before { @user_status.user_status = " " }
    it { should_not be_valid }
  end
end
