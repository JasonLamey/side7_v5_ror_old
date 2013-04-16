class Museum < ActiveRecord::Base
  attr_accessible :watched_id

  belongs_to :watcher, class_name: "Account"
  belongs_to :watched, class_name: "Account"

  validates :watcher_id, presence: true
  validates :watched_id, presence: true
end
