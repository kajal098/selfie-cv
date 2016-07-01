class CreateCources < ActiveRecord::Migration
  def change
    create_table :cources do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
