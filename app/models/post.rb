class Post < ActiveRecord::Base

  validates :title, presence: true
  validates :texts, presence: true

  has_many :comments
  belongs_to :user
end
