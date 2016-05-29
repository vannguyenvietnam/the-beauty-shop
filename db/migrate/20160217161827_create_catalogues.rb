class CreateCatalogues < ActiveRecord::Migration
  def change
    create_table :catalogues do |t|
      t.string :name
      t.integer :parent_id, default: 0

      t.timestamps null: false
    end
  end
end
