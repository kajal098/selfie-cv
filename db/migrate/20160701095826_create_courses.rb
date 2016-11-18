class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name,              null: false, default: ""
      t.timestamps null: false
    end
  end
end
