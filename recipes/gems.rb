def universal_gems
  comment "# View gems"
  gem 'haml-rails', '~> 0.4'
  gem 'will_paginate', '~> 3.0'
  gem 'bootstrap-will_paginate', '~> 0.0.9'
  gem 'simple_form', '~> 2.0'
  gem 'rails-timeago', '~> 2.2'
  # Markdown
  gem 'rdiscount', '~> 2.0.7'
  # For creating encrypted hashes in has_secure_password
  gem 'bcrypt-ruby', '~> 3.0'

  say "\n"
  comment "# Controller gems"
  gem 'strong_parameters', '~> 0.2'

  say "\n"
  comment "# i18n"
  # i18n strings for default Rails
  gem 'rails-i18n', '~> 0.7'
  # i18n for database content
  gem 'globalize3', '~> 0.3'
  gem 'localeapp', '~> 0.6'
  # For accessing i18n in js files
  gem 'i18n-js', '~> 2.1'

  say "\n"
  comment "# App & 3rd party secret key configuration"
  gem 'figaro', '~> 0.6'
end

def database_gem
  say "\n"
  comment "# Set preferred database to postgres"
  gsub_file 'Gemfile', %r(gem 'sqlite3'\n), "gem 'pg', '~> 0.15'\n"
end

def development_only_gems
  say "\n"
  comment "# :development group only gems"
  gem_group :development do
    # Annotate model/route files with their properties
    gem 'annotate', '~> 2.5'
    ### For html/erb to haml parsing; required by HAML
    gem 'html2haml', '~> 1.0'
    gem 'hpricot', '~> 0.8'
    gem 'ruby_parser', '~> 3.1'
    # Security checking
    gem 'brakeman', '~> 1.9'
    ### Code quality gems
    gem 'reek', '~> 1.3'
    gem 'rails_best_practices', '~> 1.13'
    # Query optimization monitoring
    gem 'bullet', '~> 4.5'
    # Debugging information
    gem 'rails-footnotes', '~> 3.7'
    # Better error pages
    gem 'better_errors', '~> 0.7'
    gem 'binding_of_caller', '~> 0.7'
    # Gem for RailsPanel Chrome extension
    gem 'meta_request', '~> 0.2'
  end
end

def development_and_test_gems
  say "\n"
  comment "# :development and :test group gems"
  gem_group :development, :test do
    gem 'rspec-rails', '~> 2.13'
    # for autotesting with rspec
    gem 'guard-rspec', '~> 2.5'
    # Prettier RSpec output
    gem 'fuubar', '~> 1.1'
    # Use factories instead of ActiveRecord objects
    gem 'factory_girl_rails', '~> 4.2'
    # gem 'debugger', '1.3.3' ## Broken in Ruby 2.0.0
  end
end

def test_only_gems
  say "\n"
  comment "# :test group only gems"
  gem_group :test do
    # For fake example users with “realistic” names/emails
    gem 'faker', '~> 1.1'
    # Helps in testing by simulating how a real user would use app
    gem 'capybara', '~> 2.1'
    gem 'shoulda-matchers', '~> 2.1'
    # Cucumber for user stories and db cleaner utility below
    gem 'cucumber-rails', '~> 1.3', require: false
    gem 'database_cleaner', '~> 0.9'
    # speed up test server
    gem 'spork', '~> 0.9'
    # guard/spork integration
    gem 'guard-spork', '~> 1.5'
    # Helps in debugging tests by being able to launch browser
    gem 'launchy', '~> 2.2'
    ### Code coverage reports
    gem 'simplecov', '~> 0.7', require: false
    gem 'coveralls', '~> 0.6', require: false
    # Performance testing  ## Broken in Ruby 2.0.0
    # gem 'rack-perftools_profiler', require: 'rack/perftools_profiler'
    # Test other databases on Travis CI if needed
    # gem 'mysql2', '0.3.11'
    # gem 'sqlite3', '1.3.7'
    ### Mac-dependent gems
    gem 'rb-fsevent', '~> 0.9', require: false
    # Growl notifications
    gem 'growl', '~> 1.0'
  end
end

def assets_gems
  say "\n"
  comment "# Add gems under already generated :assets group"
  insert_into_file 'Gemfile', after: "group :assets do\n" do <<-RUBY
  gem 'bootstrap-sass', '~> 2.3.1'
  gem 'font-awesome-sass-rails', '~> 3.0.2'
RUBY
  end
end