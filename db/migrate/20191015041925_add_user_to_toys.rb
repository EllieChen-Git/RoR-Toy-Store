class AddUserToToys < ActiveRecord::Migration[5.2]
  def change
    add_reference :toys, :user, foreign_key: true
  end
end
