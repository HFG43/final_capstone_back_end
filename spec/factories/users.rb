FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    username { Faker::Alphanumeric.alphanumeric(number: 10) }
  end
end
