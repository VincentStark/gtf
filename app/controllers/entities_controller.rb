class EntitiesController < ApplicationController
  protect_from_forgery except: [ :create_words, :create_sites ]
  before_filter :trusted_collector, only: [ :create_words, :create_sites ]

  def index_words
    #@entities = Entity.words.sorted(params[:sort]).paginate(page: params[:page])
    # Unsort words to minimize DB footprint
    @entities = Entity.words.paginate(page: params[:page])
    if @entities.length > 0
      render 'index'
    else
      flash[:warning] = 'Words list is empty'
      redirect_to root_path
    end
  end

  def index_sites
    #@entities = Entity.sites.sorted(params[:sort]).paginate(page: params[:page])
    # Unsort sites to minimize DB footprint
    @entities = Entity.sites.paginate(page: params[:page])
    if @entities.length > 0
      render 'index'
    else
      flash[:warning] = 'Sites list is empty'
      redirect_to root_path
    end
  end

  def show_word
    @entity = Entity.words.find_by_name(CGI.unescape(params[:name]))
    if !@entity.nil?
      render 'show'
    else
      flash[:error] = 'Word is not found'
      redirect_to root_path
    end
  end

  def show_site
    @entity = Entity.sites.find_by_name(CGI.unescape(params[:name]))
    if !@entity.nil?
      render 'show'
    else
      flash[:error] = 'Site is not found'
      redirect_to root_path
    end
  end

  def create_words
    params[:data].each do |name, measurement|
      Entity.words.create_or_update(name, params[:mname], measurement)
    end

    head :ok
  end

  def create_sites
    params[:data].each do |name, measurement|
      Entity.sites.create_or_update(name, params[:mname], measurement)
    end

    head :ok
  end
end
