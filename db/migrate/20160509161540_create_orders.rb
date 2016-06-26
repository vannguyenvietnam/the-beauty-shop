class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders, id: :uuid do |t|
      t.string :subtotal
      t.string :tax
      t.string :shipping
      t.integer :total
      t.uuid :order_status_id

      t.timestamps null: false
    end
    add_index :orders, :order_status_id
  end
end
