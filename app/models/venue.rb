# == Schema Information
#
# Table name: venues
#
#  id          :integer          not null, primary key
#  name        :string
#  address     :text
#  category_id :integer
#  latitude    :float
#  longitude   :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Venue < ActiveRecord::Base
  belongs_to :category
  has_many :check_ins, :dependent => :destroy

  geocoded_by :address
  after_validation :geocode

  validates :name, presence: true
end
