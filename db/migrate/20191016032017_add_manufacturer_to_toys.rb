class AddManufacturerToToys < ActiveRecord::Migration[5.2]
  def change
    add_reference :toys, :manufacturer, foreign_key: true
  end
end
