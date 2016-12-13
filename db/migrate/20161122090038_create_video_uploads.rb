class CreateVideoUploads < ActiveRecord::Migration
  def change
    create_table :video_uploads do |t|
    	t.string :file,              default: ''
    	t.integer :role,             default: 1
      	t.timestamps null: false
    end
  end
end
