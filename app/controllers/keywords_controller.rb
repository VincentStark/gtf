class KeywordsController < ApplicationController
  protect_from_forgery except: [ :create ]
  before_filter :trusted_collector, only: [ :create ]

  def index
    @keywords = Keyword.paginate(page: params[:page])
    if @entities.length > 0
      render 'index'
    else
      flash[:warning] = 'Keyword list is empty'
      redirect_to root_path
    end
  end

  def show
    @keyword = Keyword.find_by_keyword(CGI.unescape(params[:keyword]))
    if !@entity.nil?
      render 'show'
    else
      flash[:error] = 'Keyword is not found'
      redirect_to root_path
    end
  end

  def create
    params[:data].each do |keyword, data|
      Keyword.create_or_update(keyword, data)
    end

    head :ok
  end
end
