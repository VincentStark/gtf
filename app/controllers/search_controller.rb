class SearchController < ApplicationController
  def index
    query = params[:search][:query]
    if query.length > 2
      @words = Entity.words.search(query)
      @sites = Entity.sites.search(query)
    else
      flash.now[:error] = 'Query is too short'
    end
  end
end
