class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items, id: :uuid do |t|
      t.uuid :product_id
      t.uuid :order_id
      t.integer :unit_price
      t.integer :quantity
      t.integer :total_price

      t.timestamps null: false
    end
    add_index :order_items, :product_id
    add_index :order_items, :order_id
    add_index :order_items, [:product_id, :order_id], unique: true
  end
end
