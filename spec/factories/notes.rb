FactoryBot.define do
  factory :note do
    title { Faker::Lorem.word }
    text { Faker::Lorem.paragraph }
    category_id { nil }
  end
end
