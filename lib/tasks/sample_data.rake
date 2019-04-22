namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    # Keywords
    keywords = [ "ability", "access", "adapter", "algorithm", "alliance", "analyzer", "application",
              "approach", "architecture", "archive", "artificial intelligence", "array", "attitude",
              "complexity", "concept", "conglomeration", "contingency", "core", "customer",
              "leverage", "matrices", "matrix", "methodology", "middleware", "migration",
              "support", "synergy", "system engine", "task-force", "throughput", "time-frame" ]

    keywords.map do |keyword|
      Keyword.create!(keyword: keyword)
    end

    # Data
    (1.month.ago.to_date..Date.today).map do |date|
      keywords.shuffle.each_with_index do |keyword, data|
        KeywordData.create!(
          keyword: Keyword.find_by_keyword(keyword),
          data: data,
          collected_at: date.at_midnight
        )
      end
    end
  end
end
