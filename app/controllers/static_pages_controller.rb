class StaticPagesController < ApplicationController
  def index
    @words = Word.google.find(:all, :order => "google, words.id ASC", :limit => 5)
    @sites = Site.google.find(:all, :order => "google, sites.id ASC", :limit => 5)
  end

  def about
  end
end
