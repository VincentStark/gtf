class WordsController < ApplicationController
  protect_from_forgery except: [ :create ]
  before_filter :trusted_collector, only: [ :create ]

  def index
    field = params[:sort]
    field = 'google DESC' if field == nil

    @words = Word.sorted(field).paginate(page: params[:page])
  end

  def show
    entity = Word.find_by_name(CGI.unescape(params[:name]))

    if entity.nil?
      render :template => '/shared/_not_found'
    else
      render :template => '/shared/_show_entity',
             :locals => { :mtype => 'word',
                          :entity => entity }
    end
  end

  def create
    params[:data].each do |word, measurement|
      Word.create_or_update(word, params[:mname], measurement)
    end 

    # Everything's OK
    head :ok
  end
end
