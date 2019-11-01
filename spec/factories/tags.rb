FactoryBot.define do
  sequence(:id) { |n| n }

  factory :tag do
    name { "tag_" + generate(:id).to_s }    
  end
end
