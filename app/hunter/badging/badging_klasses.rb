# require_relative 'cheapest'
# require_relative 'ideal_price_margin'
#
module Hunter
  module Badging
    module BadgingKlasses
      ALL = [
        Hunter::Badging::Cheapest,
        Hunter::Badging::IdealPriceMargin,
        Hunter::Badging::AcceptsDirectCheckout,
      ]
    end
  end
end
