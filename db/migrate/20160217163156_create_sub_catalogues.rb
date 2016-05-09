class CreateSubCatalogues < ActiveRecord::Migration
  def change
    create_table :sub_catalogues do |t|
      t.string :name
      t.references :catalogue, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
