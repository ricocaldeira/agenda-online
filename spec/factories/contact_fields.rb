FactoryGirl.define do
  factory :contact_field do
    name "MyFieldName"
    field_type "text"
    required false
    contact_schema
  end
end