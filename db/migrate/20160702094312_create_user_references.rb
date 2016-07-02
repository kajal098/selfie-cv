class CreateUserReferences < ActiveRecord::Migration
  def change
    create_table :user_references do |t|
      t.integer :user_id
      t.string :title
      t.string :ref_type
      t.string :from
      t.string :email
      t.string :contact
      t.date   :date
      t.string :location
      t.string :file

      t.timestamps null: false
    end
    add_index :user_references, [:user_id]
    add_foreign_key :user_references, :users, on_delete: :cascade
  end
end
