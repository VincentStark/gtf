class SearchController < ApplicationController
  def index
    query = params[:search][:query]
    if query.length > 3
      @words = Word.select('*').from('(' +
                 Word.last_measurement
                   .where([ 'measurement_id = ?', Measurement.find_by_mtype_and_name('word', 'Google') ]).to_sql + ') words')
                   .where([ "name ILIKE ?", "%" + query + "%" ])
                 .order('value DESC')
      @sites = Site.select('*').from('(' +
                 Site.last_measurement
                   .where([ 'measurement_id = ?', Measurement.find_by_mtype_and_name('site', 'Google') ]).to_sql + ') sites')
                   .where([ "name ILIKE ?", "%" + query + "%" ])
                 .order('value DESC')
    else
      @error = 'Query is too short'
    end
  end
end
