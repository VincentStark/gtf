source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.1'

gem 'activerecord-session_store'

# Compatibility
gem 'protected_attributes'

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'haml-rails'

gem 'sass-rails'

gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails',
                              :github => 'anjlab/bootstrap-rails'
#gem 'bootstrap-sass'
#gem 'bootstrap-will_paginate'
gem 'will_paginate'

group :production do
  gem 'unicorn'
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3'
  gem 'thin'
  gem 'rspec-rails'
  gem 'annotate'
  gem 'faker'
  gem 'cane'
  gem 'rails_best_practices'
  gem 'travis-lint'
end

group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'annotate'
  gem 'faker'
  gem 'cane'
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'rvm-capistrano'
end

group :assets do
  gem 'coffee-rails'
  gem 'compass-rails', "~> 2.0.alpha.0"
  gem 'uglifier'
end
