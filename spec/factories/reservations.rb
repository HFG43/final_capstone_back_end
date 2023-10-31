FactoryBot.define do
  factory :reservation do
    user
    experience
    date { Time.now }
    city { Faker::Address.city }
  end
end