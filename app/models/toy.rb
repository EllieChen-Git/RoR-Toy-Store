class Toy < ApplicationRecord
    belongs_to :user
    has_one :manufacturer
end