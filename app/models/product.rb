class Product < ApplicationRecord
  has_many :cart_products, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre
  attachment :image

  validates :name, presence: true
  validates :image, presence: true
  validates :detail, presence: true
  validates :tax_excluded_price, presence: true
  validates :is_active, inclusion: [true, false]

  def add_tax_included_price
    (self.tax_excluded_price * 1.10).round
  end
  
  def self.search(search)
    if search != ""
      Product.where('name LIKE ?', "%#{search}%")
    else
      Product.all
    end
  end
end
