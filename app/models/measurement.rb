class Measurement < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true

  has_many :measurement_values
end
