class ListingDecorator < OpenStruct
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

  def condition_color
    ConditionColorsDecorator.color_class(condition)
  end
end
