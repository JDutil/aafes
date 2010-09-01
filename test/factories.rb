Factory.define :user do |f|
  f.confirmed true
  f.confirmed_on 1.day.ago
  f.sequence(:email) {|i| "test#{i}@email.com" }
  f.password "password"
  f.password_confirmation "password"
end

Factory.define :unconfirmed_user, :parent => :user do |f|
  f.confirmed nil
  f.confirmed_on nil
end

Factory.define :client do |f|
  f.sequence(:name) {|i| "client i"}
  f.sequence(:facility_number) {|i| "1234#{i}"}
end

Factory.define :transaction do |f|
  f.association :user, :factory => :user
  f.association :client, :factory => :client
  f.sequence(:cc_number) {|i| i }
  f.amount 1000
  f.sequence(:auth_code) {|i| i }
  f.sequence(:auth_ticket) {|i| i }
  f.sequence(:order_id) {|i| i }
end

Factory.define :settlement do |f|
  f.association :user, :factory => :user
  f.association :transaction, :factory => :transaction
  f.amount 1000
end

Factory.define :approval do |f|
  f.association :user, :factory => :user
  f.association :transaction, :factory => :transaction
  f.amount 1000
end

Factory.define :credit do |f|
  f.association :user, :factory => :user
  f.association :transaction, :factory => :transaction
  f.amount 1000
end

Factory.define :role do |f|
  f.title "client"
  f.association :user, :factory => :user
end

Factory.define :admin_role, :parent => :role do |f|
  f.title "admin"
end

Factory.define :client_user do |f|
  f.association :user, :factory => :user
  f.association :client, :factory => :client
end