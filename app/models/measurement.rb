class Measurement < ActiveRecord::Base
  attr_accessible :name, :mtype, :url
  validates :name, presence: true
  validates :mtype, presence: true
  validates :url, presence: true

  has_many :measurement_values

  scope :measurement_words, where(:mtype => 0)
  scope :measurement_sites, where(:mtype => 1)
end
