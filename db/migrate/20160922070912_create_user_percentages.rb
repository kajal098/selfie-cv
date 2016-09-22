class CreateUserPercentages < ActiveRecord::Migration
  def change
    create_table :user_percentages, id: false do |t|
      t.string :id, null:false, default: ""
      t.string :value, null:false, default: ""
      t.timestamps null: false
    end
  end
end
