module Hunter
  module Badging
    module BadgingKlasses
      GENERIC_BADGERS = [
        Hunter::Badging::Cheapest,
        Hunter::Badging::IdealPriceMargin,
        Hunter::Badging::AcceptsDirectCheckout,
      ]

      BADGERS_FOR_LOW_PRICE_GROUP = [
        Hunter::Badging::MultipleRecentSales,
        Hunter::Badging::RecentSalesNearLowestPrice
      ]
    end
  end
end
