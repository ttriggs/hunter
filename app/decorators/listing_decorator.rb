class ListingDecorator < OpenStruct
  CONDITION_COLORS = {
                        "Like New" => "00FF00",
                        "Mint" => "72DF3B",
                        "Excellent" => "008C00",
                        "Very Good" => "005000",
                        "Good" => "005500",
                        "Fair" => "#FFFF00",
                        "Poor" => "#FFFF00"
                     }
  def web_url
    links["web"]["href"]
  end

  def links
    _links
  end

  def display_price
    "$#{price["amount"]}"
  end

  def display_shipping
    "$#{shipping["us_rate"]["amount"]}"
  end

  def display_photos
    photos.first(2).map do |data|
      data["_links"]["small_crop"]["href"]
    end
  end

  def condition_bg_color
    CONDITION_COLORS["#{condition}"]
  end
end
