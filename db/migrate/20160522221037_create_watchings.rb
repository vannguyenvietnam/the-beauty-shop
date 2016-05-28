class CreateWatchings < ActiveRecord::Migration
  def change
    create_table :watchings do |t|
      t.integer :product_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :watchings, :product_id
    add_index :watchings, :user_id
    add_index :watchings, [:product_id, :user_id], unique: true
  end
end
