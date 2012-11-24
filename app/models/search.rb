class Search < ActiveRecord::Base
  attr_accessible :begin_date, :begin_time, :building_id, :end_date, :end_time
  has_many :listings
  
  def listings
    @listings ||= find_listings
  end

  private

  def find_listings
    listings = Listing.order("start_date ASC")
    listings = listings.where(building_id: building_id) if building_id.present?
    # listings = listings.where(:start_date => ( begin_date...end_date) ) if begin_date.present?
    listings = listings.where("start_date <= ?", begin_date) if begin_date.present?
    listings = listings.where("end_date >= ?", begin_date) if begin_date.present?
    # products = products.where("name like ?", "%#{keywords}%") if keywords.present?
    # products = products.where(category_id: category_id) if category_id.present?
    # products = products.where("price >= ?", min_price) if min_price.present?
    # products = products.where("price <= ?", max_price) if max_price.present?
    listings
  end
end
