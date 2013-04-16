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

class UserLink < ActiveRecord::Base
  attr_accessible :name, :nsfw, :sort_order, :url

  belongs_to :account

  validates :account_id, presence: true
  validates :name,       presence: true
  validates :url,        presence: true
  validates :nsfw,       presence: true, :length => { maximum: 1 }

  default_scope order: 'user_links.sort_order ASC'
end
