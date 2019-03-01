FactoryBot.define do
  sequence :nickname do |n|
    "person#{n}"
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do |f|
    f.nickname {generate(:nickname)}
    f.email    {generate(:email)}
    f.password {'password'}
  end
end
