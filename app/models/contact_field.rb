class ContactField < ActiveRecord::Base
  belongs_to :contact_schema
  validates :name, presence: true, uniqueness: true
end
