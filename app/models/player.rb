class Player < ApplicationRecord
    belongs_to :team

    # after_commit :update_avg_and_ops
    self.per_page = 20


    def update_avg_and_ops
        avg = (self.hits)/(self.at_bats) rescue 0

        #finding the opb value
        obp_numerator = self.hits+self.walks+self.hit_by_pitch
        obp_denominator = self.at_bats+self.walks+self.sacrifice_flies+self.hit_by_pitch
        obp = obp_numerator/obp_denominator

        #finding the slg value
        slg_numerator = (1*self.hits)+(2*self.doubles)+(3*self.triples)+(4*self.home_runs)
        slg_denominator = self.at_bats
        slg = slg_numerator/slg_denominator

        #finding the ops value
        ops = obp+slg
        
        self.update(avg: avg,ops: ops)
    end
end
