# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
c = Client.create(:name=>"6019123456789101", :facility_number=>"12345678")
r = Role.create(:title=>"admin")
rc = Role.create(:title=>"client")

u = User.create(:email=>"jdutil21@gmail.com", :password=>"seed", :password_confirmation=>"seed", :confirmed=>true, :confirmed_on=>DateTime.now)
u.roles = [r]
u.clients = [c]
u.save