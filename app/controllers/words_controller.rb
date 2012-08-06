class WordsController < ApplicationController
  def index
    sort = params[:sort]
    sort = "google" if sort == nil

    # TO FIX: Make this code more flexible to the new measurements
    if sort.include?("google")
      words_scope = Word.google
    else
      words_scope = Word
    end

    @words = words_scope.order(sort + ", words.id ASC").paginate(page: params[:page])
  end

  def show
    entity = Word.find_by_name(CGI.unescape(params[:name]))

    if entity.nil?
      render :template => '/shared/_not_found'
    else
      render :template => '/shared/_show_entity',
             :locals => { :type => 'Words',
                          :entity => entity,
                          :measurements => Measurement.measurement_words }
    end
  end

  def search
    entity = Word.find_by_name(params[:entity][:name])
    if entity.nil?
      # TO FIX: Model inconsistency
      entity = Site.find_by_name(params[:entity][:name])
      if entity.nil?
        render :template => '/shared/_not_found'
      else
        render :template => '/shared/_show_entity',
               :locals => { :type => 'Sites',
                            :entity => entity,
                            :measurements => Measurement.measurement_sites }
      end
    else
      render :template => '/shared/_show_entity',
             :locals => { :type => 'Words',
                          :entity => entity,
                          :measurements => Measurement.measurement_words }
    end
  end
end
