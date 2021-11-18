class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_products  , dependent: :destroy
  has_many :orders         , dependent: :destroy
  has_many :deliveries     , dependent: :destroy

  def full_name
   last_name + " " + first_name
  end

  def full_name_kana
    last_name_kana + " " + first_name_kana
  end

  def full_name_no_blanks
    last_name + first_name
  end

  def full_address
    "〒" + self.postal_code + "  " + self.address
  end
end
