class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings, :id => false do |t|
      t.string :id
      t.string :value

      t.timestamps null: false
    end
  end
end
