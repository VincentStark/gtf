namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    # Fill words
    words = [ "ability", "access", "adapter", "algorithm", "alliance", "analyzer", "application", 
              "approach", "architecture", "archive", "artificial intelligence", "array", "attitude",
              "complexity", "concept", "conglomeration", "contingency", "core", "customer", 
              "leverage", "matrices", "matrix", "methodology", "middleware", "migration", 
              "support", "synergy", "system engine", "task-force", "throughput", "time-frame" ]

    for word in words
      Word.create!(name: word)
    end

    # Fill sites
    sites = [ "absolutelymadness.net", "att.net", "authorize.net", "battle.net", "bellsouth.net",
              "breeders.net", "cableone.net", "centurylink.net", "centurytel.net", "charter.net",
              "cheerfully.net", "email.secureserver.net", "employeeconnection.net", "estatesales.net",
              "etc.uhaul.net", "examiner.net", "fieldglass.net", "flowhot.net", "frontiernet.net",
              "groceries.net", "guessmovies.net", "laworks.net", "paint.net", "secureserver.net" ]

    for site in sites
      Site.create!(name: site)
    end

    # Fill measurements
    measurements = [ "Google Searches", "AdWords Rank", "Alexa Rank" ]

    for measurement in measurements
      Measurement.create!(name: measurement)
    end

    # Fill measurement values (words)
    for word in Word.all
      MeasurementValue.create!(
        measurement: Measurement.find_by_name("Google Searches"),
        word: word,
        value: rand*100,
        collected_at: Time.at(Time.now - rand * 6.months)
      )
    end

    # Fill measurement values (sites)
    for site in Site.all
      MeasurementValue.create!(
        measurement: Measurement.find_by_name("AdWords Rank"),
        site: site,
        value: rand*100,
        collected_at: Time.at(Time.now - rand * 6.months)
      )
      MeasurementValue.create!(
        measurement: Measurement.find_by_name("Alexa Rank"),
        site: site,
        value: rand*100,
        collected_at: Time.at(Time.now - rand * 6.months)
      )
    end

  end
end
