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

class Journal < ActiveRecord::Base
  attr_accessible :allow_comments, :body, :privacy, :title

  belongs_to :account

  validates :account_id, presence: true
  validates :body, presence: true
  validates_columns :allow_comments, :privacy #enum columns

  default_scope order: 'journals.created_at DESC'
end
