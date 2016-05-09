class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :quantity
      t.references :sub_catalogue, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
