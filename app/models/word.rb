class Word < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true

  has_many :measurement_values

  scope :last_measurement,
    joins('LEFT JOIN measurement_values ON measurement_values.word_id = words.id')
      .select('DISTINCT ON (words.id, measurement_values.measurement_id) words.*, measurement_values.value')
      .order('words.id, measurement_values.measurement_id, measurement_values.collected_at DESC')

  scope :google,
    where([ 'measurement_id = ?', Measurement.find_by_mtype_and_name('word', 'Google') ])

  def self.topN(n)
    Word
      .select('*')
      .from('(' + Word.last_measurement.google.to_sql + ') words')
      .order('value DESC')
      .limit(n)
  end

  def self.search(query)
    Word
      .topN(100)
      .where([ "name ILIKE ? ESCAPE '!'", "%" + query.gsub(/[!%_]/) { |x| '!' + x } + "%"])
  end

  def self.sorted(field)
    if field.include?('name')
      Word
        .select('DISTINCT *')
        .from('(' + Word.last_measurement.to_sql + ') words')
        .order(field)
    else
      field_optimized = field.include?('DESC') ? 'value DESC' : 'value'
      Word
        .select('*')
        .from('(' + Word
                      .last_measurement
                      .where([ 'measurement_id = ?', Measurement.find_by_mtype_and_name('word', field.split(' ')[0].capitalize) ]).to_sql + ') words')
        .order(field_optimized)
    end
  end

  def self.create_or_update(word, mname, measurement)
    # Find or create the entity itselt
    e = Word.find_or_create_by_name(name: word)
    collected_at = Date.today.at_midnight

    # Create or update measurement value
    mv = MeasurementValue.find_or_initialize_by_measurement_id_and_word_id_and_collected_at(
      Measurement.find_by_name_and_mtype(mname, 'word'),
      e,
      collected_at
    )

    mv.update_attributes({
      measurement: Measurement.find_by_name_and_mtype(mname, 'word'),
      word: e,
      value: measurement,
      collected_at: collected_at
    })
  end

end
