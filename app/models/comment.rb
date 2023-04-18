class Comment < ApplicationRecord
  audited
  validates :content, presence: true
  belongs_to :post, counter_cache: true
  belongs_to :user
end
