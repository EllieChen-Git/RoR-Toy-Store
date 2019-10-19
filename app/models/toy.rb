class Toy < ApplicationRecord
    belongs_to :user
    has_one :manufacturer

    has_many :categories_toys
    has_many :categories, through: :categories_toys
end