FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }

    trait :regular do
      role "Regular"
    end

    trait :manager do
      role "Manager"
    end
  end
end
