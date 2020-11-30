class League < ApplicationRecord
    belongs_to :season
    has_many :divisions
end
