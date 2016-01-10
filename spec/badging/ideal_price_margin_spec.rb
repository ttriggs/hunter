require 'spec_helper'

describe Hunter::Badging::IdealPriceMargin do
  let(:sufficient_price_margin) { Hunter::Badging::IdealPriceMargin::MINIMUM_PRICE_MARGIN_FOR_BADGE }
  let(:listing1_price) { 10 }
  let(:listing2_price) { listing1_price + margin_before2 }
  let(:listing3_price) { listing2_price + margin_before3 }
  let(:listing4_price) { listing3_price + margin_before4 }

  let(:margin_before2) { 1 }
  let(:margin_before3) { 1 }
  let(:margin_before4) { 1 }

  let(:listing1) { Hunter::Listing.new }
  let(:listing2) { Hunter::Listing.new }
  let(:listing3) { Hunter::Listing.new }
  let(:listing4) { Hunter::Listing.new }

  let(:listings) { [listing1, listing2, listing3, listing4] }

  def badge_listings
    described_class.badge_listings(listings: listings)
  end

  def badges
    listings.map(&:badges)
  end

  describe ".badge_listings" do
    before do
      listing1.stub(:total_price) { listing1_price }
      listing2.stub(:total_price) { listing2_price }
      listing3.stub(:total_price) { listing3_price }
      listing4.stub(:total_price) { listing4_price }
      badge_listings
    end

    context "sufficient price margin does not exist within the first 4 listings" do
      it "does not add badges to any listings" do
        badges.all?(&:empty?).should be_truthy
      end
    end

    context "sufficient price margin exists between first and second listing" do
      let(:margin_before2) { sufficient_price_margin }

      it "badges only the first listing" do
        badges.select(&:present?).count.should == 1
        badges.first.should include(Hunter::Badging::IdealPriceMargin::BADGE)
      end
    end

    context "sufficient price margin exists between second and third listing" do
      let(:margin_before3) { sufficient_price_margin }

      it "badges the first and second listings" do
        badges.select(&:present?).count.should == 2
        badges.first(2).all? do |badge|
          badge.include?(Hunter::Badging::IdealPriceMargin::BADGE).should be_truthy
        end
      end
    end

    context "sufficient price margin exists between third and fourth listing" do
      let(:margin_before4) { sufficient_price_margin }

      it "badges the first three listings" do
        badges.select(&:present?).count.should == 3
        badges.first(3).all? do |badge|
          badge.include?(Hunter::Badging::IdealPriceMargin::BADGE).should be_truthy
        end
      end
    end
  end
end

