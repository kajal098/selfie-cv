class CreateVideoUploads < ActiveRecord::Migration
  def change
    create_table :video_uploads do |t|
    	t.string :file,              default: ''
      t.timestamps null: false
    end
  end
end
