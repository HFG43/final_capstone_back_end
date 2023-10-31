FactoryBot.define do
  factory :experience do 
    name { Faker::Food.dish }
    description { Faker::Food.description }
    experience_fee { Faker::Number.decimal(l_digits: 3, r_digits: 3) }
    add_testing_fee { Faker::Number.decimal(l_digits: 3, r_digits: 3) }
    reserve_full_table { Faker::Number.decimal(l_digits: 3, r_digits: 3) }
    guests { Faker::Number.within(range: 1..10) }
    image { Faker::LoremFlickr.image }
  end
end
