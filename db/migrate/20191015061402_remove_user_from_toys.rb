class RemoveUserFromToys < ActiveRecord::Migration[5.2]
  def change
    remove_column :toys, :user, :string
  end
end
