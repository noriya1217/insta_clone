FactoryBot.define do
  factory :comment do
    blog { nil }
    content { "MyText" }
  end
end
