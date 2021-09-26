FactoryBot.define do
  factory :answer do
    body { Faker::Lorem.characters(number: 10) }
  end
end
