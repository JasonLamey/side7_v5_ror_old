# == Schema Information
#
# Table name: date_visibilities
#
#  id         :integer          not null, primary key
#  visibility :string(45)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe DateVisibility do
  before { @visibility = DateVisibility.new(visibility: 'Test') }

  subject { @visibility }

  it { should respond_to(:visibility) }
  it { should respond_to(:account)    }

  it { should be_valid }

  describe "when visibility is not present" do
    before { @visibility.visibility = " " }
    it { should_not be_valid }
  end
end
