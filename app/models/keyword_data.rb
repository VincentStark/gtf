class KeywordData < ActiveRecord::Base
  attr_accessible :keyword, :data, :collected_at
  validates :keyword, presence: true
  validates :data, presence: true

  belongs_to :keyword
end
