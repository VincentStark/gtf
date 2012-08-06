class SitesController < ApplicationController
  def index
    sort = params[:sort]
    sort = "google" if sort == nil

    # TO FIX: Make this code more flexible to the new measurements
    if sort.include?("google")
      sites_scope = Site.google
    elsif sort.include?("alexa")
      sites_scope = Site.alexa
    else
      sites_scope = Site
    end

    @sites = sites_scope.order(sort + ", sites.id ASC").paginate(page: params[:page])
  end

  def show
    entity = Site.find_by_name(CGI.unescape(params[:name]))

    if entity.nil?
      render :template => '/shared/_not_found'
    else
      render :template => '/shared/_show_entity',
             :locals => { :type => 'Sites',
                          :entity => entity,
                          :measurements => Measurement.measurement_sites }
    end
  end
end
