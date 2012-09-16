class MeasurementValue < ActiveRecord::Base
  attr_accessible :measurement, :entity, :value, :collected_at
  validates :measurement, presence: true
  validates :entity, presence: true
  validates :value, presence: true
  validates :collected_at, presence:true

  belongs_to :measurement
  belongs_to :entity

  scope :latest,
    select('DISTINCT ON (entity_id) measurement_values.*')
    .order('entity_id, collected_at DESC')
end
