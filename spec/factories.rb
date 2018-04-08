FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
  end

  factory :regular, parent: :user, class: 'Regular' do
  end

  factory :manager, parent: :user, class: 'Manager' do
  end

  factory :issue do
    title { Faker::Superhero.name }
    description { Faker::Lorem.paragraph }
    status Issue::StatusPending
  end
end
