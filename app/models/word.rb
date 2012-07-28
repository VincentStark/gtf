class Word < ActiveRecord::Base
  attr_accessible :word
  validates :word, presence: true

  has_many :attribute_values
  has_many :attributes, :through => :attribute_values
end
