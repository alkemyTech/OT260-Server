require 'faker'

puts 'Creating roles...'

Role.destroy_all

Role.create!(
  [
    { name: 'administrator', description: 'admin user' },
    { name: 'standard', description: 'standard user' },
    { name: 'regular', description: 'regular user' },
  ]
)

puts 'Roles created:'

Role.all.each { |role| puts "* #{role.name}" }

puts 'Creating users...'

User.destroy_all

User.create!(first_name: 'admin',
            last_name: 'admin',
            email: 'admin@somosmas.org',
            password: 'password-admin',
            role: Role.find_by(name: 'administrator')
)

(1..10).each do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create!(
    first_name: first_name,
    last_name: last_name,
    email: "standard.#{first_name.downcase}.#{last_name.downcase}@somosmas.org",
    password: 'password-standard',
    role: Role.find_by(name: 'standard')
  )
end

(1..10).each do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create!(
    first_name: first_name,
    last_name: last_name,
    email: "regular.#{first_name.downcase}.#{last_name.downcase}@somosmas.org",
    password: "password-regular",
    role: Role.find_by(name: 'regular')
  )
end

puts 'Users created:'

User.all.each { |user| puts "*#{user.email}" }
