class SearchController < ApplicationController
  def index
    @words = Word.find(:all, :conditions => [ "name ILIKE ?", "%" + params[:search][:query] + "%" ])
    @sites = Site.find(:all, :conditions => [ "name ILIKE ?", "%" + params[:search][:query] + "%" ])
  end
end
