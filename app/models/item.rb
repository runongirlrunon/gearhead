class Item < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :brand, presence: true
  validates :model, presence: true
end
