class WordsController < ApplicationController
  protect_from_forgery except: [ :create ]
  before_filter :trusted_collector, only: [ :create ]

  def index
    sort = params[:sort]
    sort = "google DESC" if sort == nil

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

  def create
    params[:data].each do |word, measurement|

      # Find or create the entity itselt
      w = Word.find_or_create_by_name(name: word)
      collected_at = Date.today.at_midnight

      # Create or update measurement value
      mv = MeasurementValue.find_or_initialize_by_measurement_id_and_word_id_and_collected_at(
        Measurement.find_by_name_and_mtype(params[:mname], 'word'),
        w,
        collected_at
      )
      mv.update_attributes({
        measurement: Measurement.find_by_name_and_mtype(params[:mname], 'word'),
        word: w,
        value: measurement,
        collected_at: collected_at
      })
    end 

    # Everything's OK
    head :ok
  end
end
