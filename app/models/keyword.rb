class Keyword < ActiveRecord::Base
  attr_accessible :keyword
  validates :keyword, presence: true

  has_many :keyword_data

  def self.topN(n)
  end

  def self.search(query)
  end

  def self.sorted(field)
  end

  def self.create_or_update(keyword, data)

    keyword_id = Keyword.find_or_create_by_name(keyword: keyword)
    collected_at = Date.today.at_midnight

    keyword_data_object = KeywordData
      .find_or_initialize_by_keyword_id_and_collected_at(
        keyword_id,
        collected_at
      )

    keyword_data_object.update_attributes({
      keyword_id: keyword_id,
      data: data,
      collected_at: collected_at
    })
  end

end
