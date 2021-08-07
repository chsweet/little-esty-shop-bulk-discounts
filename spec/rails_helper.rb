# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'simplecov'
SimpleCov.start

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'faker'

# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

repo_info = {:id=>389774449, :name=>"little-esty-shop"}

contributor_info = [
  {id: 56685055,:login=>"InOmn1aParatus", :contributions=>75},
  {id: 79383963,:login=>"amcguire17", :contributions=>42},
  {id: 77654906,:login=>"ealwafai", :contributions=>41},
  {id: 81600649,:login=>"chsweet", :contributions=>35}
]
pulls_info = [
  {user:{:login=>"InOmn1aParatus"}},
  {user:{:login=>"ealwafai"}},
  {user:{:login=>"chsweet"}},
  {user:{:login=>"ealwafai"}},
  {user:{:login=>"amcguire17"}}
]

RSpec.configure do |config|
  config.before(:each, :type => :feature) do
    allow(GithubService).to receive(:repo_info).and_return(repo_info)
    allow(GithubService).to receive(:contributor_info).and_return(contributor_info)
    allow(GithubService).to receive(:pulls_info).and_return(pulls_info)
  end
end

holidays = [
  {"date":"2021-09-06","localName":"Labor Day","name":"Labour Day"},
  {"date":"2021-10-11","localName":"Columbus Day","name":"Columbus Day"},
  {"date":"2021-11-11","localName":"Veterans Day","name":"Veterans Day"},
  {"date":"2021-11-25","localName":"Thanksgiving Day","name":"Thanksgiving Day"},
  ]

RSpec.configure do |config|
  config.before(:each, :type => :feature) do
    allow(NagerDateService).to receive(:holidays).and_return(holidays)
  end
end
