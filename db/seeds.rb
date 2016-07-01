# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create(email: 'admin@example.com', password: '12345678' , username: 'admin' , role: 'Admin' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'nicolecross1579@gmail.com', password:'12345678' , username: 'nicole' , role: 'Student' ) 
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'daisy@gmail.com', password: '12345678' , username: 'daisy' , role: 'Faculty' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'sam@gmail.com', password: '12345678' , username: 'sam' , role: 'Jobseeker' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'parnel@gmail.com', password: '12345678' , username: 'parnel' , role: 'Company' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)

