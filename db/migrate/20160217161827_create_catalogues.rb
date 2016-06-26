class CreateCatalogues < ActiveRecord::Migration
  def change
    create_table :catalogues, id: :uuid do |t|
      t.string :name
      t.uuid :parent_id

      t.timestamps null: false
    end    
  end
end
