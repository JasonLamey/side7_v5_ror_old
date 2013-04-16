# == Schema Information
#
# Table name: user_types
#
#  id         :integer          not null, primary key
#  user_type  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserType < ActiveRecord::Base
  attr_accessible :user_type

  has_one :account, :inverse_of => :user_type

  validates :user_type, presence: true
end
