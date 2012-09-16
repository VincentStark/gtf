class Site < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true

  has_many :measurement_values

  scope :last_measurement,
    joins('LEFT JOIN measurement_values ON measurement_values.site_id = sites.id')
      .select('DISTINCT ON (sites.id, measurement_values.measurement_id) sites.*, measurement_values.value')
      .order('sites.id, measurement_values.measurement_id, measurement_values.collected_at DESC')

  scope :google,
    where([ 'measurement_id = ?', Measurement.find_by_mtype_and_name('site', 'Google') ])

  def self.topN(n)
    Site
      .select('*')
      .from('(' + Site.last_measurement.google.to_sql + ') sites')
      .order('value DESC')
      .limit(n)
  end

  def self.search(query)
    Site
      .topN(100)
      .where([ "name ILIKE ? ESCAPE '!'", "%" + query.gsub(/[!%_]/) { |x| '!' + x } + "%"])
  end

  def self.sorted(field)
    if field.include?('name')
      Site
        .select('DISTINCT *')
        .from('(' + Site.last_measurement.to_sql + ') sites')
        .order(field)
    else
      field_optimized = field.include?('DESC') ? 'value DESC' : 'value'
      Site
        .select('*')
        .from('(' + Site
                      .last_measurement
                      .where([ 'measurement_id = ?', Measurement.find_by_mtype_and_name('site', field.split(' ')[0].capitalize) ]).to_sql + ') sites')
        .order(field_optimized)
    end
  end

  def self.create_or_update(site, mname, measurement)
    # Find or create the entity itselt
    e = Site.find_or_create_by_name(name: site)
    collected_at = Date.today.at_midnight

    # Create or update measurement value
    mv = MeasurementValue.find_or_initialize_by_measurement_id_and_site_id_and_collected_at(
      Measurement.find_by_name_and_mtype(mname, 'site'),
      e,
      collected_at
    )

    mv.update_attributes({
      measurement: Measurement.find_by_name_and_mtype(mname, 'site'),
      site: e,
      value: measurement,
      collected_at: collected_at
    })
  end

end
