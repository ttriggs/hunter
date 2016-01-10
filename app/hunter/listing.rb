module Hunter
  class Listing < OpenStruct
    def url
      links["web"]["href"]
    end

    def links
      _links
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
  end
end
