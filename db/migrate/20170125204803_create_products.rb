class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :tag_line
      t.string :description
      t.string :application_notes
      t.string :size
      t.string :aloop_number
      t.decimal :price
      t.attachment :image
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
