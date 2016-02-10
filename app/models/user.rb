class User < ActiveRecord::Base
  after_initialize :create_default_contact_schema

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :contacts, dependent: :destroy
  has_one :contact_schema, dependent: :destroy

  private

  def create_default_contact_schema
    self.build_contact_schema.save unless self.contact_schema
  end
end
