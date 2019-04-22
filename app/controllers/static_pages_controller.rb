class StaticPagesController < ApplicationController
  def index
    @keywords = Keyword.topN(7)
  end
end
