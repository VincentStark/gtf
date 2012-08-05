class SitesController < ApplicationController
  def index
    sort = params[:sort]
    sort = "sites.name" if sort == nil

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
end
