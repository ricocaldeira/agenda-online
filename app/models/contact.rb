class Contact < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true
  store :properties, coder: JSON

  validate :validate_properties

  def validate_properties
    if self.user_id
      contact_schema = User.find_by(id: self.user_id).contact_schema
      contact_schema.fields.each do |field|
        if field.required? && properties[field.name].blank?
          errors.add field.name, "must not be blank"
        end
      end
    end
  end

end