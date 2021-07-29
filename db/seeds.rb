# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Admin.create!(
    email: "a@a",
    password: "aaaaaa"
)

30.times do |n|
    gimei = Gimei.new
    address = Gimei.address
    email = Faker::Internet.email
    tel = Faker::Number.number(digits: 11).to_s
    postal_code = Faker::Number.number(digits: 7).to_s
    EndUser.create(
        last_name: gimei.last.kanji,
        first_name: gimei.first.kanji,
        last_name_kana: gimei.last.katakana,
        first_name_kana: gimei.first.katakana,
        address: address.kanji,
        email: email,
        phone_number: tel,
        postal_code: postal_code,
        password: "password"
    )
end
