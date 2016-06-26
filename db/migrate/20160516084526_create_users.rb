class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.boolean :admin, default: false
      t.string :reset_digest
      t.datetime :reset_send_at

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end
end
