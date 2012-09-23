namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    # Fill words
    words = [ "ability", "access", "adapter", "algorithm", "alliance", "analyzer", "application",
              "approach", "architecture", "archive", "artificial intelligence", "array", "attitude",
              "complexity", "concept", "conglomeration", "contingency", "core", "customer",
              "leverage", "matrices", "matrix", "methodology", "middleware", "migration",
              "support", "synergy", "system engine", "task-force", "throughput", "time-frame" ]

    words.map do |word|
      Entity.words.create!(name: word)
    end

    # Fill sites
    sites = [ "absolutelymadness.net", "att.net", "authorize.net", "battle.net", "bellsouth.net",
              "breeders.net", "cableone.net", "centurylink.net", "centurytel.net", "charter.net",
              "cheerfully.net", "email.secureserver.net", "employeeconnection.net", "estatesales.net",
              "etc.uhaul.net", "examiner.net", "fieldglass.net", "flowhot.net", "frontiernet.net",
              "groceries.net", "guessmovies.net", "laworks.net", "paint.net", "secureserver.net" ]

    sites.map do |site|
      Entity.sites.create!(name: site)
    end

    # Add measurements
    Measurement.all.map do |m|

      # Assign random "rating"
      if m.name == "Google"
        (1.month.ago.to_date..Date.today).map do |date|
          words.shuffle.each_with_index do |word, i|
            MeasurementValue.create!(
              measurement: m,
              entity: Entity.words.find_by_name(word),
              value: i,
              collected_at: date.at_midnight
            )
          end
        end
      end

      if [ "Google", "Compete" ].include? m.name
        (1.month.ago.to_date..Date.today).map do |date|
          sites.shuffle.each_with_index do |site, i|
            MeasurementValue.create!(
              measurement: m,
              entity: Entity.sites.find_by_name(site),
              value: i,
              collected_at: date.at_midnight
            )
          end
        end
      end
    end
  end
end
