class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string  :name,              null:false, default: ""
      t.boolean  :default_status,            default: false
      t.timestamps null: false
    end
  end
end
