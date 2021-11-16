class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      
      t.integer :genre_id,           null: false, default: ""
      t.string  :name,               null: false, default: ""
      t.text    :detail,             null: false, default: ""
      t.integer :tax_excluded_price, null: false, default: ""
      t.string  :image_id,           null: false, default: ""
      t.boolean :is_active,          null: false, default: true
      
      t.timestamps
    end
  end
end
