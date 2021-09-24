FactoryBot.define do
  factory :follow do
    association :user
    association :following, factory: :user
  end
end
