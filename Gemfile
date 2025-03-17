# frozen_string_literal: true

source 'https://rubygems.org'
gemspec

rails_version = ENV['CI_RAILS_VERSION'] || '>= 0.0'

gem "activerecord", rails_version

if ['~> 8.0.0', '>= 0', '>= 0.0'].include?(rails_version)
  gem 'sqlite3', '~> 2'
else
  gem 'sqlite3', '~> 1.7.3'
end
gem 'typeprof'
gem 'logger'
gem 'mutex_m'
gem 'base64'
gem 'bigdecimal'
gem 'benchmark'
