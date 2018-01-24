class Photo < ApplicationRecord

  mount_uploader :image, PhotoUploader

  # Default order is set by services order_listed attribute 
  default_scope -> { order(order_listed: :asc) }
  validates :title, presence: true

  def self.increment_order(id, order_listed)
    Photo.where("order_listed >= ? AND id != ?", order_listed, id).update_all("order_listed = order_listed + 1")
  end

  def self.decrement_order(id, order_listed)
    Photo.where("order_listed > ? AND id != ?", order_listed, id).update_all("order_listed = order_listed - 1")
  end

end
