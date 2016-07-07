FactoryGirl.define do
  factory :wiki do
    title Faker::Hipster.sentence
    body Faker::Hipster.paragraph
    private Faker::Boolean.boolean(0.5)
    user
  end
end
