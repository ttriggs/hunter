module Hunter
  class Listing < OpenStruct
    delegate :price_guide_synopsis, :price_guide_web_url, to: :listing_details
    delegate :transactions, :total_transactions, to: :price_guide_details

    def web_url
      links["web"]["href"]
    end

    def details_url
      links["self"]["href"]
    end

    def links
      _links
    end

    def ships_to_us?
      shipping["us"]
    end

    def product_price
      price["amount"].to_f
    end

    def shipping_price
      shipping["us_rate"]["amount"].to_f
    end

    def total_price
      ( product_price + shipping_price ).round(2)
    end

    def listing_photos
      photos.first(2).map do |data|
        data["_links"]["small_crop"]["href"]
      end
    end

    def add_badge(new_badges)
      Array(new_badges).each do |new_badge|
        @badges << new_badge unless badges.include?(new_badge)
      end
    end

    def badges
      @badges ||= []
    end

    def listing_details
      @_listing_details ||= Hunter::ReverbAPI::ListingDetails.details(listing: self)
    end

    def price_guide_details
      @_price_guide_details ||= Hunter::ReverbAPI::PriceGuideDetails.details(listing: self)
    end

    def total_recent_sales_after(date:)
      transactions.take_while do |transaction|
        transaction["date"] > date
      end.count
    end
  end
end
