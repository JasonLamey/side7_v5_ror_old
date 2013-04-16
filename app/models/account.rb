# == Schema Information
#
# Table name: accounts
#
#  id                      :integer          not null, primary key
#  user_id                 :integer          not null
#  first_name              :string(45)
#  last_name               :string(45)
#  user_type_id            :integer          default(1), not null
#  user_status_id          :integer          default(1), not null
#  reinstate_on            :date
#  other_aliases           :string(255)
#  biography               :text
#  birthday                :date             not null
#  birthday_visibility     :integer          default(1), not null
#  webpage_name            :string(255)
#  webpage_url             :string(255)
#  blog_name               :string(255)
#  blog_url                :string(255)
#  aim                     :string(45)
#  yahoo                   :string(45)
#  gtalk                   :string(45)
#  skype                   :string(45)
#  state                   :string(255)
#  country_id              :integer
#  is_public               :integer
#  referred_by             :integer
#  subscription_expires_on :date
#  delete_on               :date
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class Account < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :other_aliases, :biography, :birthday, :birthday_visibility, 
                  :webpage_name, :webpage_url, :blog_name, :blog_url, :aim, :yahoo,
                  :gtalk, :skype, :state, :country_id, :referred_by

  belongs_to :user,        inverse_of: :account
  belongs_to :user_status, inverse_of: :account
  belongs_to :user_type,   inverse_of: :account
  belongs_to :visibility,  inverse_of: :account
  belongs_to :country,     inverse_of: :account

  has_many :journals,   dependent: :destroy
  has_many :user_links, dependent: :destroy

  has_many :relationships,         class_name: "Friend", foreign_key: "account_id", dependent: :destroy
  has_many :friended_accounts,     through: :relationships, source: :friend
  has_many :reverse_relationships, class_name: "Friend", foreign_key: "friend_id", dependent: :destroy
  has_many :friended_backs,        through: :reverse_relationships, source: :account

  has_many :museums, foreign_key: "watcher_id", dependent: :destroy
  has_many :watched_accounts, through: :museums, source: :watched
  has_many :reverse_museums, class_name: "Museum", foreign_key: "watched_id", dependent: :destroy
  has_many :watchers, through: :reverse_museums, source: :watcher

  has_one :user_preference, inverse_of: :account, dependent: :destroy

  validates :user_id,        presence: true
  validates :user_status_id, presence: true
  validates :user_type_id,   presence: true

  def friends?(other_acct)
    relationships.find_by_friend_id(other_acct.id)
  end

  def make_friend!(other_acct, approved=0)
    relationships.create!(friend_id: other_acct.id, approved: approved)
  end

  def approve_friend!(other_acct)
    request = reverse_relationships.find_by_account_id(other_acct.id)
    request.approved = 1
    request.save!
    self.make_friend!(other_acct, 1)
  end

  def unfriend!(other_acct)
    relationships.find_by_friend_id(other_acct.id).destroy
    backs = self.friended_backs
    if backs.include?(other_acct)
      reverse_relationships.find_by_account_id(other_acct.id).destroy
    end
  end

  def watching?(other_acct)
    museums.find_by_watched_id(other_acct.id)
  end

  def watch!(other_acct)
    museums.create!(watched_id: other_acct.id)
  end

  def unwatch!(other_acct)
    museums.find_by_watched_id(other_acct.id).destroy
  end
end
