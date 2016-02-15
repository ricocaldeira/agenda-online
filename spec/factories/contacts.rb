FactoryGirl.define do
  factory :contact do
    name "Contact Name"
    email "contact@email.com"
    user
  end
end
