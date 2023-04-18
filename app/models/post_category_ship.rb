class PostCategoryShip < ApplicationRecord
  audited
  belongs_to :post
  belongs_to :category
end
