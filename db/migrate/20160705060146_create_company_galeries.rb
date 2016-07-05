class CreateCompanyGaleries < ActiveRecord::Migration
  def change
    create_table :company_galeries do |t|
      t.integer :user_id
      t.string :file,              default: ''

      t.timestamps null: false
    end
    add_index :company_galeries, [:user_id]
    add_foreign_key :company_galeries, :users, on_delete: :cascade
  end
end
