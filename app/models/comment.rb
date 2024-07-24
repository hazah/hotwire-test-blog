class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :title, presence: true,
                    length: { minimum: 5 }
  validates :body, presence: true,
                    length: { minimum: 0 }
  validates :post_id, presence: true
  validates :user_id, presence: true
end
