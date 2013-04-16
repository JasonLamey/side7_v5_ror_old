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

class Friend < ActiveRecord::Base
  attr_accessible :approved, :friend_id
  attr_accessor   :approved

  belongs_to :account
  belongs_to :friend, class_name: "Account"

  validates :account_id, presence: true
  validates :friend_id,  presence: true
  validates :approved,   presence: true
end
