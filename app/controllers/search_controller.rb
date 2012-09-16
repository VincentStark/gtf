class SearchController < ApplicationController
  def index
    query = params[:search][:query]
    if query.length > 2
      @words = Word.search(query)
      @sites = Site.search(query)
    else
      flash.now[:error] = 'Query is too short'
    end
  end
end
