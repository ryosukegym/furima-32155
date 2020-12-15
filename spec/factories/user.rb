FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name             { Faker::Name.first_name }
    first_name            { Faker::Name.last_name  }
    last_name_katakana    { gimei.last.katakana }
    first_name_katakana   { gimei.first.katakana }
    birthday              { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
