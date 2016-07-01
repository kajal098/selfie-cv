class CreateUserCertificates < ActiveRecord::Migration
  def change
    create_table :user_certificates do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
