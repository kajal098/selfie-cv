class CreateUserCertificates < ActiveRecord::Migration
  def change
    create_table :user_certificates do |t|
      t.integer :user_id
      t.string :certificate_type,              null: false, default: ""
      t.string :name,              null: false, default: ""
      t.string :year,              null: false, default: ""
      t.string :file,              default: ''
      t.string :text_field,              null: false, default: ""
      t.string :file_type,              null: false, default: ""
      t.boolean :active,            default: false
      t.timestamps null: false
    end
    add_index :user_certificates, [:user_id]
    add_foreign_key :user_certificates, :users, on_delete: :cascade
  end
end
