class Post < ApplicationRecord
  audited
  default_scope { where(deleted_at: nil) }
  validates :title, presence: true
  validates :content, presence: true

  has_many :comments, dependent: :destroy
  has_many :post_category_ships
  has_many :categories, through: :post_category_ships
  belongs_to :user

  mount_uploader :image, ImageUploader

  scope :recent, -> { order(created_at: :desc) }
  scope :today, -> { where('created_at >= ?', Time.current.beginning_of_day) }

  delegate :email, to: :user, prefix: :user
  def destroy
    update(deleted_at: Time.now)
  end
end
