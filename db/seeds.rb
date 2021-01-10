# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

user = User.new(
    email: 'admin@example.com', 
    password: 'password', 
    password_confirmation: 'password' 
)

user.skip_confirmation! 
user.save!

30.times do
    Course.create!([{
        title: Faker::Educator.course_name,
        short_description: Faker::TvShows::GameOfThrones.quote,
        description: Faker::Quote.famous_last_words,
        language: Faker::ProgrammingLanguage.name,
        level: 'Beginner',
        price: Faker::Number.between(from: 100, to: 1000),
        user_id: User.first.id
    }])
end