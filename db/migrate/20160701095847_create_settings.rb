class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :resume_per, null:false, default: 40
      t.string :achievement_per, null:false, default: 10
      t.string :curricular_per, null:false, default: 10
      t.string :whizquiz_per, null:false, default: 10
      t.string :future_goal_per, null:false, default: 10
      t.string :working_env_per, null:false, default: 10
      t.string :reference_per, null:false, default: 10
      t.string :site_name, null:false, default: 'abcdefghigklmnopqrstuvwxyz'
      t.string :site_email, null:false, default: 'abcdefghigklmnopqrstuvwxyz'
      t.string :site_phone, null:false, default: 'abcdefghigklmnopqrstuvwxyz'
      t.string :site_fax, null:false, default: 'abcdefghigklmnopqrstuvwxyz'
      t.string :facebook_url, null:false, default: 'abcdefghigklmnopqrstuvwxyz'
      t.string :twitter_url, null:false, default: 'abcdefghigklmnopqrstuvwxyz'
      t.string :google_plus_url, null:false, default: 'abcdefghigklmnopqrstuvwxyz'
      t.string :bronze, null:false, default: 2
      t.string :silver, null:false, default: 3
      t.string :gold, null:false, default: 5
      t.timestamps null: false
    end
  end
end
