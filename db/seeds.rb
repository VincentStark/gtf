# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Seed measurements
measurements = [ { name: "Google", mtype: "word", url: "http://www.google.com/insights/search/#&date=today%201-m&cmpt=q&q=" },
                 { name: "Google", mtype: "site", url: "http://www.google.com/insights/search/#&date=today%201-m&cmpt=q&q=" },
                 { name: "Alexa", mtype: "site", url: "http://www.alexa.com/siteinfo/" } ]

for measurement in measurements
  Measurement.create!(name: measurement[:name],
                      mtype: measurement[:mtype],
                      url:  measurement[:url])
end
