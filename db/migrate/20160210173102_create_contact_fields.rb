class CreateContactFields < ActiveRecord::Migration
  def change
    create_table :contact_fields do |t|
      t.string :name
      t.string :field_type
      t.boolean :required
      t.belongs_to :contact_schema, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
