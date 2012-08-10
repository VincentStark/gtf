class SitesController < ApplicationController
  def index
    sort = params[:sort]
    sort = "google" if sort == nil

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
end
