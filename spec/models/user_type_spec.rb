# == Schema Information
#
# Table name: user_types
#
#  id         :integer          not null, primary key
#  user_type  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe UserType do
  before { @user_type = UserType.new(user_type: 'Test') }

  subject { @user_type }

  it { should respond_to(:user_type) }
  it { should respond_to(:account)     }

  it { should be_valid }

  describe "when user_type is not present" do
    before { @user_type.user_type = " " }
    it { should_not be_valid }
  end
end
