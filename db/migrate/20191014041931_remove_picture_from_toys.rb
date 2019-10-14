class RemovePictureFromToys < ActiveRecord::Migration[5.2]
  def change
    remove_column :toys, :picture, :text
  end
end
