class CreateUserEducations < ActiveRecord::Migration
  def change
    create_table :user_educations do |t|
      t.integer :user_id
      t.integer :cource_id
      t.integer :specialization_id
      t.string :year
      t.string :school
      t.string :skill

      t.timestamps null: false
    end
    add_index :user_educations, [:user_id]
    add_foreign_key :user_educations, :users, on_delete: :cascade
    add_index :user_educations, [:cource_id]
    add_foreign_key :user_educations, :cources, on_delete: :cascade
    add_index :user_educations, [:specialization_id]
    add_foreign_key :user_educations, :specializations, on_delete: :cascade
  end
end
