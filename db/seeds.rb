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
user = User.create(email: 'admin11111@example.com', password: '12345678' , username: 'admin11111' , role: 'Admin' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'nicolecross157911111@gmail.com', password:'12345678' , username: 'nicole11111' , role: 'Student' ) 
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'daisy11111@gmail.com', password: '12345678' , username: 'daisy11111' , role: 'Faculty' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'sam11111@gmail.com', password: '12345678' , username: 'sam11111' , role: 'Jobseeker' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'parnel11111@gmail.com', password: '12345678' , username: 'parnel11111' , role: 'Company' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)

Course.create(name: "BE")
Course.create(name: "ME")
Course.create(name: "MBA")
Course.create(name: "PHD")
Course.create(name: "BTECH")

Specialization.create(name: "Computer")
Specialization.create(name: "Electrical")
Specialization.create(name: "Information Technology")
Specialization.create(name: "Civil")
Specialization.create(name: "Power and Electronics")

