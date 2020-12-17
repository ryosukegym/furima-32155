FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name             { '田中' }
    first_name            { '太郎' }
    last_name_katakana    { Gimei.last.katakana }
    first_name_katakana   { Gimei.first.katakana }
    birthday              { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
