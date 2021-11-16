class Product < ApplicationRecord
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
end
