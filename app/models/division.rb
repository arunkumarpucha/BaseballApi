class Division < ApplicationRecord
    belongs_to :league
    has_many :teams
end
