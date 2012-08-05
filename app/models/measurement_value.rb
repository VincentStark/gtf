class MeasurementValue < ActiveRecord::Base
  attr_accessible :measurement, :word, :site, :value, :collected_at
  validates :measurement, presence: true
  validates :word, presence: { :unless => :site }
  validates :value, presence: true
  validates :collected_at, presence:true

  belongs_to :measurement
  belongs_to :word
  belongs_to :site
end
