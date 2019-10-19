class Category < ApplicationRecord
    has_many :categories_toys
    has_many :toys, through: :categories_toys
end
