class StaticPagesController < ApplicationController
  def index
    @words = Entity.words.topN(7)
    @sites = Entity.sites.topN(7)
  end
end
