class AddApprovedToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :approved, :boolean, default: false
  end
end
