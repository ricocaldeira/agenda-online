class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.text :properties
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
