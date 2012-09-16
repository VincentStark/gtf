class Measurement < ActiveRecord::Base
  attr_accessible :name, :url
  validates :name, presence: true
  validates :url, presence: true

  has_many :measurement_values
end
