class WordsController < ApplicationController
  def index
    sort = params[:sort]
    sort = "google" if sort == nil

    if sort.include?("name")
      @words = Word.select('DISTINCT *').from('(' +
                 Word.last_measurement.to_sql + ') words')
               .order(sort)
               .paginate(page: params[:page])
    else
      order = sort.include?("DESC") ? 'value DESC' : 'value'
      @words = Word.select('*').from('(' +
                 Word.last_measurement
                   .where([ 'measurement_id = ?', Measurement.find_by_mtype_and_name('word', sort.split(' ')[0].capitalize) ]).to_sql + ') words')
               .order(order)
               .paginate(page: params[:page])
    end
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
end
