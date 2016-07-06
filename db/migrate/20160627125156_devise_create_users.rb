class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.integer :role,              null: false, default: 0
      t.string :title,              null:false, default: ""
      t.string :email,              null: false, default: ""
      t.string :username,              null: false, default: ""
      t.string :first_name,              null: false, default: ""
      t.string :middle_name,              null: false, default: ""
      t.string :last_name,              null: false, default: ""
      t.string :profile_pic,              default: ''
      t.string :gender,              null: false, default: ""
      t.string :date_of_birth,              :default => Date.today 
      t.string :nationality,              null: false, default: ""
      t.string :address,              null: false, default: ""
      t.string :city,              null: false, default: ""
      t.string :zipcode,              null: false, default: ""
      t.string :contact_number,              null: false, default: ""
      t.string :education_in,              null: false, default: ""
      t.string :school_name,              null: false, default: ""
      t.string :year,              null: false, default: ""
      t.string :file,              default: ''
      t.string :file_type,              null: false, default: ""
      t.string :faculty_work_with_type,              null: false, default: ""
      t.string :faculty_uni_name,              null: false, default: ""
      t.string :faculty_subject,              null: false, default: ""
      t.string :faculty_designation,              null: false, default: ""
      t.string :faculty_join_from,              :default => Date.today      
      t.string :company_name,              null: false, default: ""
      t.string :company_establish_from,              null: false, default: ""
      t.string :company_industry,              null: false, default: ""
      t.string :company_functional_area,              null: false, default: ""
      t.string :company_address,              null: false, default: ""
      t.string :company_zipcode,              null: false, default: ""           
      t.string :company_city,              null: false, default: ""
      t.string :company_contact,              null: false, default: ""
      t.string :company_skype_id,              null: false, default: ""
      t.string :company_id,              null: false, default: ""
      t.string :company_logo,              default: ''
      t.string :company_profile,              default: ''
      t.string :company_brochure,              default: ''
      t.string :company_website,              null: false, default: ""
      t.string :company_facebook_link,              null: false, default: ""
      t.string :company_turnover,              null: false, default: ""
      t.string :company_no_of_emp,              null: false, default: ""
      t.string :company_growth_ratio,              null: false, default: ""
      t.string :companu_new_ventures,              null: false, default: ""
      t.string :company_future_turnover,              null: false, default: ""
      t.string :company_future_new_venture_location,              null: false, default: ""
      t.string :company_future_outlet,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_code, limit: 6
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :users, :username,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
