module Hunter
  class CreateListingsFromSearchResults

    def self.create(search_results:, saved_search:)
      new(search_results: search_results, saved_search: saved_search).create
    end

    def initialize(search_results:, saved_search:)
      @search_results = search_results
      @saved_search = saved_search
    end

    def create
      search_results[:listings].each do |search_result|
        Listing.new(saved_search: saved_search).tap do |listing|
          listing.update_attributes(params_for_new_listing(search_result))
          listing.photos << photos(search_result)
          listing.save!
        end
      end
    end

    private

    attr_reader :saved_search, :search_results

    def params_for_new_listing(search_result)
      {
        title: search_result[:title],
        make: search_result[:make],
        model: search_result[:model],
        year: search_result[:year],
        condition: search_result[:condition],
        shop: search_result[:shop_name],
        offers: search_result[:offers_enabled],
        price_cents: price_cents(search_result),
        shipping_cents: shipping_cents(search_result),
        url: url(search_result),
        reverb_id: reverb_id(search_result),
      }
    end

    def photos(search_result)
      search_result[:photos].first(2).map do |data|
        Photo.create(link: data["_links"]["small_crop"]["href"])
      end
    end

    def price_cents(search_result)
      search_result[:price][:amount].to_f * 100
    end

    def shipping_cents(search_result)
      search_result[:shipping][:us_rate][:amount].to_f * 100
    end

    def url(search_result)
      search_result[:_links][:web][:href]
    end

    def reverb_id(search_result)
      # capture '1290561' from urls like:
      # "https://reverb.com/item/1290561-2008-boss-dd-3-digital-delay-with-switchable-analog-mod"
      url(search_result).split("/").last.split("-").first
    end
  end
end
