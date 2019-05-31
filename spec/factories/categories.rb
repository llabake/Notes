FactoryBot.define do
  factory :category do
    name { Faker::Movies::StarWars.character }
  end
end
