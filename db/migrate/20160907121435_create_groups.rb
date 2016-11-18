class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name,              null: false, default: ""
      t.string :slug,               null: false, default: ""
      t.integer :code,              null: false, default: ""
      t.string :group_pic,              default: ''
      t.integer :deleted_from, array: true, default: []     
      t.timestamps null: false
    end
    add_index :groups, :slug, unique: true
  end
end
