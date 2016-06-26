class CreateOrderStatuses < ActiveRecord::Migration
  def change
    create_table :order_statuses, id: :uuid do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
