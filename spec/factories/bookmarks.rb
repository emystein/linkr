FactoryBot.define do
  factory :bookmark do
      title {"MyString"}
      notes {"MyText"} 
      user_id {1}
      location_id {1}
  end
end