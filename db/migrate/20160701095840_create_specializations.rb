class CreateSpecializations < ActiveRecord::Migration
  def change
    create_table :specializations do |t|
      t.string :name,              null: false, default: ""

      t.timestamps null: false
    end
  end
end
