# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  email_address   :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email_address, :password, :password_confirmation, :username
  has_secure_password

  before_save { |user| user.email_address = email_address.downcase }

  # Validations

  validates :username,      presence: true, length: { maximum: 45, minimum: 3 },
                            uniqueness: { case_sensitive: false }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email_address, presence:   true, 
                            format:     { with: VALID_EMAIL_REGEX },
                            uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
end
