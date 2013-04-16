# == Schema Information
#
# Table name: countries
#
#  id         :integer          not null, primary key
#  name       :string(45)
#  code       :string(3)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Country < ActiveRecord::Base
  attr_accessible :code, :name

  belongs_to :account

  validates :code, presence: true
  validates :name, presence: true
end
