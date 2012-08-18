class SitesController < ApplicationController
  protect_from_forgery except: [ :create ]
  before_filter :trusted_collector, only: [ :create ]

  def index
    sort = params[:sort]
    sort = "google DESC" if sort == nil

    if sort.include?("name")
      @sites = Site.select('DISTINCT *').from('(' +
                 Site.last_measurement.to_sql + ') sites')
               .order(sort)
               .paginate(page: params[:page])
    else
      order = sort.include?("DESC") ? 'value DESC' : 'value'
      @sites = Site.select('*').from('(' +
                 Site.last_measurement
                   .where([ 'measurement_id = ?', Measurement.find_by_mtype_and_name('site', sort.split(' ')[0].capitalize) ]).to_sql + ') sites')
               .order(order)
               .paginate(page: params[:page])
    end
  end

  def show
    entity = Site.find_by_name(CGI.unescape(params[:name]))

    if entity.nil?
      render :template => '/shared/_not_found'
    else
      render :template => '/shared/_show_entity',
             :locals => { :mtype => 'site',
                          :entity => entity }
    end
  end

  def create
    params[:data].each do |site, measurement|

      # Find or create the entity itselt
      w = Site.find_or_create_by_name(name: site)
      collected_at = Date.today.at_midnight

      # Create or update measurement value
      mv = MeasurementValue.find_or_initialize_by_measurement_id_and_site_id_and_collected_at(
        Measurement.find_by_name_and_mtype(params[:mname], 'site'),
        w,
        collected_at
      )
      mv.update_attributes({
        measurement: Measurement.find_by_name_and_mtype(params[:mname], 'site'),
        site: w,
        value: measurement,
        collected_at: collected_at
      })
    end 

    # Everything's OK
    head :ok
  end
end
