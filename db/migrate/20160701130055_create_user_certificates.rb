class CreateUserCertificates < ActiveRecord::Migration
  def change
    create_table :user_certificates do |t|
      t.string :type
      t.string :name
      t.string :year
      t.string :file

      t.timestamps null: false
    end
  end
end
