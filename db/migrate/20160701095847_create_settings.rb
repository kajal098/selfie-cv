class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :site_name, null:false, default: 'Selfiecv.com'
      t.string :site_email, null:false, default: 'selfiecv2016@gmail.com'
      t.string :site_phone, null:false, default: '9988776655'
      t.string :site_fax, null:false, default: '432456'
      t.string :facebook_url, null:false, default: 'www.facebook.com/Selfiecv'
      t.string :twitter_url, null:false, default: 'www.twitter.com/Selfiecv'
      t.string :google_plus_url, null:false, default: 'www.google.com/Selfiecv'
      t.string :whizquiz_time, default: 0
      t.string :marketiq_time, default: 0

      t.timestamps null: false
    end
  end
end
