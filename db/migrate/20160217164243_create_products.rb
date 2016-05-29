class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.integer :quantity
      t.boolean :active, default: true
      t.string :picture
      t.references :catalogue, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
