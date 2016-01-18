module Hunter
  module Badging
    module BadgingKlasses
      ALL = [
        Hunter::Badging::Cheapest,
        Hunter::Badging::IdealPriceMargin,
        Hunter::Badging::AcceptsDirectCheckout,
        Hunter::Badging::MultipleRecentSales, # should be run after IdealPriceMargin
      ]
    end
  end
end
