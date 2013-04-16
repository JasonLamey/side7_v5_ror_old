class UserPreference < ActiveRecord::Base
  attr_accessible :allow_email_through_forms, :allow_favoriting, :allow_pms, :allow_watching, :comment_notifications, :content_display_type, 
                  :default_comment_type, :default_comment_visibility, :display_full_sized_images, :display_signature, :pms_notifications, 
                  :show_adult_content, :show_m_thumbs, :show_management_thumbs, :show_online, :thumbnail_size

  belongs_to :account, inverse_of: :user_preference

  validates :account_id, presence: true
  validates :allow_email_through_forms, presence: true
  validates :allow_favoriting, presence: true
  validates :allow_pms, presence: true
  validates :allow_watching, presence: true
  validates :comment_notifications, presence: true
  validates :display_signature, presence: true
  validates :pms_notifications, presence: true
  validates :show_adult_content, presence: true
  validates :show_m_thumbs, presence: true
  validates :show_management_thumbs, presence: true
  validates :show_online, presence: true
  
  validates_columns :content_display_type, :default_comment_type, :default_comment_visibility, 
                    :display_full_sized_images, :thumbnail_size
end
