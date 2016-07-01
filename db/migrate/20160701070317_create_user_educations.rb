class CreateUserEducations < ActiveRecord::Migration
  def change
    create_table :user_educations do |t|
      t.integer :user_id
      t.integer :cource
      t.integer :specialization
      t.string :year
      t.string :school
      t.string :skill

      t.timestamps null: false
    end
    add_index :user_educations, [:user_id]
    add_foreign_key :user_educations, :users, on_delete: :cascade
  end
end
