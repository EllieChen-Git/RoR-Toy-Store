class Manufacturer < ApplicationRecord
    has_many :toys, dependent: :destroy
end
