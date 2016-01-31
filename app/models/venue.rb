class Venue < ActiveRecord::Base
	belongs_to :category

	geocoded_by :address
	after_validation :geocode
end
