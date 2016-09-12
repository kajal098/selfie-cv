class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :text,              null: false, default: ""
      t.boolean :role, default: false

      t.timestamps null: false
    end
  end
end
