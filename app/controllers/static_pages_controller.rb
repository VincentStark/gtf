class StaticPagesController < ApplicationController
  def index
    @words = Word.topN(7)
    @sites = Site.topN(7)
  end
end
