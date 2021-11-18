# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#管理者
Admin.create!(
  email: 'glass_tech@email.com',
  password: 'glass_tech'
  )

  # 会員
  15.times do |n|
      Customer.create!(
        email: "hanako#{n + 1}@test.com",
        password: "111111",
        last_name: "山田",
        first_name: "花子#{n + 1}",
        last_name_kana: "ヤマダ",
        first_name_kana: "ハナコ",
        address: "東京都渋谷区ちぇるちぇるランド",
        postal_code: "0000000",
        phone_number: "09012345678",
      )
  end

  # 配送先
  Delivery.create!(
    customer_id: 1,
    name: "山田一郎",
    address: "東京都渋谷区こりん星",
    postal_code: "1111111",
  )


  # ジャンル
  Genre.create!(
    name: "ケーキ"
  )
  Genre.create!(
    name: "キャンディ"
  )
  Genre.create!(
    name: "焼き菓子"
  )
  Genre.create!(
    name: "プリン"
  )

  # 商品
  Product.create!(
    genre_id: 1,
    name: "カップケーキ",
    detail: "3個入り",
    image: File.open("#{Rails.root}/app/assets/images/apple_pie.jpeg"),
    is_active: true,
    tax_excluded_price: 1000
  )
  Product.create!(
    genre_id: 1,
    name: "ショートケーキ",
    detail: "おいしいいいいい！",
    image: File.open("#{Rails.root}/app/assets/images/caramel_cookie.jpeg"),
    is_active: true,
    tax_excluded_price: 500
  )
  Product.create!(
    genre_id: 1,
    name: "ミルフィーユ",
    detail: "いちごいっぱいだよ",
    image: File.open("#{Rails.root}/app/assets/images/Dacquoise.jpeg"),
    is_active: true,
    tax_excluded_price: 600
  )
  Product.create!(
    genre_id: 2,
    name: "キャンディー",
    detail: "マカロン",
    image: File.open("#{Rails.root}/app/assets/images/Maritozzo.jpeg"),
    is_active: true,
    tax_excluded_price: 300
  )

  15.times do |n|
    # カート商品
    CartProduct.create!(
      customer_id: 15 - n,
      product_id: 1,
      quantity: 2
    )

    # 注文
    Order.create!(
      customer_id: 15 - n,
      postage: 800,
      name: "山田花子",
      address: "東京都渋谷区ちぇるちぇるランド",
      postal_code: "0000000",
      total_price: "10800",
      payment_method: 0,
      status: 4,
      created_at: (15 - n).day.ago
    )
  end

