class AddKitToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :kit, :string
  end
end
