class AddCollectedAtToKeywordData < ActiveRecord::Migration
  def change
    add_column :keyword_data, :collected_at, :datetime
  end
end
