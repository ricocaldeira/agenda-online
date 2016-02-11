class ContactSchema < ActiveRecord::Base
  belongs_to :user
  has_many :fields, class_name: "ContactField", dependent: :destroy
  accepts_nested_attributes_for :fields, allow_destroy: true
end
