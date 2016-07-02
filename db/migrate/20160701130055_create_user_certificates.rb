class CreateUserCertificates < ActiveRecord::Migration
  def change
    create_table :user_certificates do |t|
      t.integer :user_id
      t.string :type
      t.string :name
      t.string :year
      t.string :file

      t.timestamps null: false
    end
    add_index :user_certificates, [:user_id]
    add_foreign_key :user_certificates, :users, on_delete: :cascade
  end
end
