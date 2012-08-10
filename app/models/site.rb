class Site < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true

  has_many :measurement_values

  scope :last_measurement,
        joins('LEFT JOIN measurement_values ON measurement_values.site_id = sites.id')
          .select('DISTINCT ON (sites.id, measurement_values.measurement_id) sites.*, measurement_values.value')
          .order('sites.id, measurement_values.measurement_id, measurement_values.collected_at DESC')
end
