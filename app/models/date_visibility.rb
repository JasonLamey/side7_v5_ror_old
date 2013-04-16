# == Schema Information
#
# Table name: date_visibilities
#
#  id         :integer          not null, primary key
#  visibility :string(45)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DateVisibility < ActiveRecord::Base
  attr_accessible :visibility

  has_one :account, :inverse_of => :visibility

  validates :visibility, presence: true
end
