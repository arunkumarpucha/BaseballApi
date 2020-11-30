class Team < ApplicationRecord
    belongs_to :division
    has_many :players
end
