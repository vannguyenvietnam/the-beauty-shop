class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.string :email
      t.string :name
      t.string :address
      t.string :phone
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
