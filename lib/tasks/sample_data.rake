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
    measurements = [ { name: "Google", mtype: "word", url: "http://www.google.com/insights/search/#&date=today%201-m&cmpt=q&q=" },
                     { name: "Google", mtype: "site", url: "http://www.google.com/insights/search/#&date=today%201-m&cmpt=q&q=" },
                     { name: "Alexa", mtype: "site", url: "http://www.alexa.com/siteinfo/" } ]

    for measurement in measurements
      m = Measurement.create!(name: measurement[:name],
                              mtype: measurement[:mtype],
                              url:  measurement[:url])

      if m.mtype == "word" 
        for word in Word.all
          Range.new(1.week.ago.to_i, Time.now.to_i).step(1.hour) do |time|
            MeasurementValue.create!(
              measurement: m,
              word: word,
              value: rand(100) + 1,
              collected_at: Time.at(time)
            )
          end
        end
      end

      if m.mtype == "site"
        for site in Site.all
          Range.new(1.week.ago.to_i, Time.now.to_i).step(1.hour) do |time|
            MeasurementValue.create!(
              measurement: m,
              site: site,
              value: rand(100) + 1,
              collected_at: Time.at(time)
            )
          end
        end
      end
    end
  end
end
