# == Schema Information
#
# Table name: user_statuses
#
#  id          :integer          not null, primary key
#  user_status :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserStatus < ActiveRecord::Base
  attr_accessible :user_status

  has_one :account, :inverse_of => :user_status

  validates :user_status, presence: true
end
