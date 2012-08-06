class Word < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true

  has_many :measurement_values

  # TO FIX: make this code more flexible
  scope :google,
        joins('INNER JOIN measurement_values ON measurement_values.word_id = words.id')
          .select('words.*, measurement_values.value AS google')
          .where('measurement_values.measurement_id = 1')
end
