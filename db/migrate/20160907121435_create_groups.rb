class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name,              null: false, default: ""
      t.integer :code,              null: false, default: ""
      t.string :group_pic,              default: ''
      t.integer :deleted_from, array: true, default: []
      t.datetime :deleted_at

        

      t.timestamps null: false
    end
  end
end
