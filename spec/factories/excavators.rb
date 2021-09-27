FactoryBot.define do
  factory :excavator do
    company_name { 'MyString' }
    address { 'MyString' }
    crew_on_site { false }
    association :ticket

    trait :invalid_data do
      company_name { nil }
      address { nil }
      crew_on_site { nil }
    end
  end
end
