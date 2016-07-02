class CreateUserCurriculars < ActiveRecord::Migration
  def change
    create_table :user_curriculars do |t|
      t.integer :user_id
      t.string :curricular_type
      t.string :title
      t.string :team_type
      t.string :location
      t.date :date
      t.string :file
      t.timestamps null: false
    end
    add_index :user_curriculars, [:user_id]
    add_foreign_key :user_curriculars, :users, on_delete: :cascade
  end
end
