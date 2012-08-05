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
    measurements = [ { name: "Google", mtype: 0, url: "http://www.google.com/insights/search/#&date=today%201-m&cmpt=q&q=" },
                     { name: "AdWords", mtype: 0, url: "https://adwords.google.com/o/Targeting/Explorer??__o=cues&ideaRequestType=KEYWORD_IDEAS&q=" },
                     { name: "Google", mtype: 1, url: "http://www.google.com/insights/search/#&date=today%201-m&cmpt=q&q=" },
                     { name: "Alexa", mtype: 1, url: "http://www.alexa.com/search?r=home_home&p=bigtop&q=" } ]

    for measurement in measurements
      m = Measurement.create!(name: measurement[:name],
                              mtype: measurement[:mtype],
                              url:  measurement[:url])

      for word in Word.all
        MeasurementValue.create!(
          measurement: m,
          word: word,
          value: rand(100) + 1,
          collected_at: Time.at(Time.now - rand * 6.months)
        )
      end

      for site in Site.all
        MeasurementValue.create!(
          measurement: m,
          site: site,
          value: rand(100) + 1,
          collected_at: Time.at(Time.now - rand * 6.months)
        )
      end
    end
  end
end
