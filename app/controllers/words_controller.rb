class WordsController < ApplicationController
  def index
    sort = params[:sort]
    sort = "words.name" if sort == nil

    # TO FIX: Make this code more flexible to the new measurements
    if sort.include?("google")
      words_scope = Word.google
    elsif sort.include?("adwords")
      words_scope = Word.adwords
    else
      words_scope = Word
    end

    @words = words_scope.order(sort + ", words.id ASC").paginate(page: params[:page])
  end
end
