class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products, id: :uuid do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.integer :quantity
      t.boolean :active, default: true
      t.string :picture
      
      t.timestamps null: false
    end
  end
end
