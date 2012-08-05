class Site < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true

  has_many :measurement_values

  # TO FIX: make this code more flexible
  scope :google,
        joins('INNER JOIN measurement_values ON measurement_values.site_id = sites.id')
          .select('sites.*, measurement_values.value AS google')
          .where('measurement_values.measurement_id = 3')

  scope :alexa,
        joins('INNER JOIN measurement_values ON measurement_values.site_id = sites.id')
          .select('sites.*, measurement_values.value AS alexa')
          .where('measurement_values.measurement_id = 4')
end
