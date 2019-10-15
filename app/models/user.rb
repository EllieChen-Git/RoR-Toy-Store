class User < ApplicationRecord
    has_many :toys, dependent: :destroy  
end
