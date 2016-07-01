class CreateUserAwards < ActiveRecord::Migration
  def change
    create_table :user_awards do |t|
      t.string :name
      t.string :type
      t.string :description
      t.string :file

      t.timestamps null: false
    end
  end
end
