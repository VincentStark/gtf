class SitesController < ApplicationController
  protect_from_forgery except: [ :create ]
  before_filter :trusted_collector, only: [ :create ]

  def index
    field = params[:sort]
    field = "google DESC" if field == nil

    @sites = Site.sorted(field).paginate(page: params[:page])
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
      Site.create_or_update(site, params[:mname], measurement)
    end 

    # Everything's OK
    head :ok
  end
end
