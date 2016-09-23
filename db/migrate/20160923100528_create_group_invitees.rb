class CreateGroupInvitees < ActiveRecord::Migration
  def change
    create_table :group_invitees do |t|
    	t.integer :group_id
      t.string :email, null:false, default: ""
      
      t.timestamps null: false
    end
    add_index :group_invitees, [:group_id]
    add_foreign_key :group_invitees, :groups, dependent: :delete
  end
end
