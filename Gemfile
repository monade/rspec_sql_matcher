# frozen_string_literal: true

source 'https://rubygems.org'
gemspec

rails_version = ENV['CI_RAILS_VERSION'] || '>= 0.0'

gem 'activerecord', rails_version

gem 'mysql2'
gem 'pg'
gem 'rubocop'

if ['~> 8.0.0', '>= 0', '>= 0.0'].include?(rails_version)
  gem 'sqlite3', '~> 2'
else
  gem 'sqlite3', '~> 1.7.3'
end
gem 'base64'
gem 'benchmark'
gem 'bigdecimal'
gem 'logger'
gem 'mutex_m'
gem 'typeprof'
