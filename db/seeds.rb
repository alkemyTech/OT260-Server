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

Activity.destroy_all

puts 'Creating activities...'

Activity.create!([
  { name: 'School Support for Elementary level' , content: 'The school support space is the heart of the educational area. The workshops are held from Monday to Thursday from 10 a.m. to 12 p.m. and from 2 p.m. to 4 p.m. in the counter shift. On Saturdays, the workshop is also held for boys and girls who attend school double shift. We have a special space for 1st graders 2 times a week as they need special attention! Currently, 150 boys and girls between the ages of 6 and 15 are enrolled in this program. This workshop is designed to help students with the material they bring from school, we also have a teacher who gives them language and math classes with our own planning that we put together in Manos to level the children and that they go with more tools to the school.'  },
  { name: 'High School Level School Support' , content: 'Just as in elementary this workshop is the heart of the high school area. Workshops are held from Monday to Friday from 10 a.m. to 12 p.m. and from 4 p.m. to 6 p.m. in the counter shift. Currently, 50 teenagers between the ages of 13 and 20 are enrolled in the workshop. Here the young people present themselves with the material they bring from school and a teacher from the institution and a group of volunteers receive them to help them study or do their homework. This space is also used by young people as a meeting point and relationship between them and the institution.'  },
  { name: 'Tutorships' , content: 'It is a program aimed at young people from the third year of high school, whose objective is to guarantee their permanence in school and build a life project that gives meaning to school. The objective of this proposal is to achieve the school integration of children and young people from the neighborhood by promoting the appropriate socio-educational and emotional support, developing the necessary indispensable resources through the articulation of our interventions with the schools that house them, with the families of the students and with the corresponding municipal, provincial and national authorities.'  }
])

puts 'Activities created:'

Activity.all.each { |activity| puts "*#{activity.name}" }


Category.destroy_all

puts 'Creating categories...'

Category.create!(
  [
    { name: 'Arts', description: 'description' },
    { name: 'Entertainment', description: 'description' },
    { name: 'Environment', description: 'description' },
    { name: 'Fundraiser', description: 'description' },
    { name: 'Event', description: 'description' }

  ]
)

puts 'Categories created:'

Category.all.each { |category| puts "*#{category.name}" }
