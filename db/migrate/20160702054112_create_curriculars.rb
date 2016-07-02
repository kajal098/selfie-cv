class CreateCurriculars < ActiveRecord::Migration
  def change
    create_table :curriculars do |t|
      t.string :type
      t.string :title
      t.string :team_type
      t.string :location
      t.string :date
      t.string :file

      t.timestamps null: false
    end
  end
end
