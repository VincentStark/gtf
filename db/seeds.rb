# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Seed measurements
measurements = [ { name: "Google", url: "http://www.google.com/insights/search/#&date=today%201-m&cmpt=q&q=" },
                 { name: "Compete", url: "http://siteanalytics.compete.com/" } ]

for measurement in measurements
  Measurement.create!(name: measurement[:name],
                      url:  measurement[:url])
end
