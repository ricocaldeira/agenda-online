class CreateContactSchemas < ActiveRecord::Migration
  def change
    create_table :contact_schemas do |t|
      t.text :fields
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
