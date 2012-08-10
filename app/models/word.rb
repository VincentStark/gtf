class Word < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true

  has_many :measurement_values

  scope :last_measurement,
        joins('LEFT JOIN measurement_values ON measurement_values.word_id = words.id')
          .select('DISTINCT ON (words.id, measurement_values.measurement_id) words.*, measurement_values.value')
          .order('words.id, measurement_values.measurement_id, measurement_values.collected_at DESC')
end
