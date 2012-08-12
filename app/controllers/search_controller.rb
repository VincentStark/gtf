class SearchController < ApplicationController
  def index
    query = params[:search][:query]
    if query.length > 3
      @words = Word.find(:all, :conditions => [ "name ILIKE ?", "%" + query + "%" ])
      @sites = Site.find(:all, :conditions => [ "name ILIKE ?", "%" + query + "%" ])
    else
      @error = 'Query is too short'
    end
  end
end
