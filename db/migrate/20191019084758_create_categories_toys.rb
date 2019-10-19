class CreateCategoriesToys < ActiveRecord::Migration[5.2]
  def change
    create_table :categories_toys do |t|
      t.references :category, foreign_key: true
      t.references :toy, foreign_key: true

      t.timestamps
    end
  end
end
