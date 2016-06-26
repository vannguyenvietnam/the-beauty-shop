class CreateCatProducts < ActiveRecord::Migration
  def change
    create_table :cat_products, id: :uuid do |t|
      t.uuid :catalogue_id
      t.uuid :product_id

      t.timestamps null: false
    end
    add_index :cat_products, :catalogue_id
    add_index :cat_products, :product_id
    add_index :cat_products, [:catalogue_id, :product_id], unique: true
  end
end
