class Entity < ActiveRecord::Base
  attr_accessible :name, :etype
  validates :name, presence: true
  validates_inclusion_of :etype, :in => [1, 2]

  has_many :measurement_values
  has_many :measurements, :through => :measurement_values

  scope :words,
    where(:etype => 1)

  scope :sites,
    where(:etype => 2)

  scope :last_measurement,
    joins('LEFT JOIN measurement_values ON measurement_values.entity_id = entities.id')
      .select('DISTINCT ON (entities.id, measurement_values.measurement_id) entities.*, measurement_values.value')
      .order('entities.id, measurement_values.measurement_id, measurement_values.collected_at DESC')
  
  scope :google,
    where([ 'measurement_id = ?', Measurement.find_by_name('Google') ])

  def self.topN(n)
    Entity
      .select('*')
      .from('(' + Entity.last_measurement.google.to_sql + ') entities')
      .order('value DESC')
      .limit(n)
  end

  def self.search(query)
    Entity
      .topN(100)
      .where([ "name ILIKE ? ESCAPE '!'", "%" + query.gsub(/[!%_]/) { |x| '!' + x } + "%"])
  end

  def self.sorted(field)
    field = 'google DESC' if field == nil
    if field.include?('name')
      Entity
        .order(field)
    else
      field_optimized = field.include?('DESC') ? 'value DESC' : 'value'
      Entity
        .select('*')
        .from('(' + Entity
                      .last_measurement
                      .where([ 'measurement_id = ?', Measurement.find_by_name(field.split(' ')[0].capitalize) ]).to_sql + ') entities')
        .order(field_optimized)
    end
  end

  def self.create_or_update(name, mname, measurement)

    # Find or create the entity itselt
    e = Entity.find_or_create_by_name(name: name)
    m = Measurement.find_by_name(mname)
    collected_at = Date.today.at_midnight

    # Create or update measurement value
    mv = MeasurementValue.find_or_initialize_by_measurement_id_and_entity_id_and_collected_at(
      m,
      e,
      collected_at
    )

    mv.update_attributes({
      measurement: m,
      entity: e,
      value: measurement,
      collected_at: collected_at
    })
  end

end
