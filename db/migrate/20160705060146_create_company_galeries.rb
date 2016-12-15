class CreateCompanyGaleries < ActiveRecord::Migration
  def change
    create_table :company_galeries do |t|
      t.integer :user_id
      t.string :file,              default: ''
      t.string :file_type,              null: false, default: ""
      t.string :file_status,              null: false, default: :true
      t.timestamps null: false
    end
    add_index :company_galeries, [:user_id]
    add_foreign_key :company_galeries, :users, on_delete: :cascade
  end
end
