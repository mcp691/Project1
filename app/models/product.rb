
class Product < ApplicationRecord
  has_many :orders
  has_many :comments

  validates :name, presence: true

  def highest_rating_comment
    comments.rating_desc.first
  end

  def average_rating
    comments.average(:rating).to_f
  end

  def lowest_rating_comment
    comments.rating_desc.last
  end

  def self.search(search_term)
    if Rails.env != "production"
      Product.where("name || colour || description LIKE ?", "%#{search_term}%")
    else
      Product.where("name || colour || description iLIKE ?", "%#{search_term}%")
    end
  end
end
