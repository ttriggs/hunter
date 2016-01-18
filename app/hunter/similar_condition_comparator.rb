module Hunter
  class SimilarConditionComparator
    MINT = "mint"
    MINT_WITH_INVENTORY = "mint with inventory"
    LIKE_NEW = "like new"
    EXCELLENT = "excellent"
    VERY_GOOD = "very good"
    GOOD = "good"

    SIMILARITY_HASH = {
      "tier_one" => [MINT, MINT_WITH_INVENTORY, LIKE_NEW, EXCELLENT],
      "tier_two" => [LIKE_NEW, EXCELLENT, VERY_GOOD],
      "tier_three" => [VERY_GOOD, GOOD]
    }

    def self.similar?(condition_one, condition_two)
      new(condition_one, condition_two)
    end

    def initialize(condition_one, condition_two)
      @condition_one = condition_one.try(:downcase)
      @condition_two = condition_two.try(:downcase)
    end

    def similar?
      return true if condition_one == condition_two

      SIMILARITY_HASH.values.any? do |tier|
        tier.include?(@condition_one) &&
          tier.include?(@condition_two)
      end
    end
  end
end
