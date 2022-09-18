# frozen_string_literal: true

require_relative 'sql_matcher/version'
require 'active_support'
require 'rspec/sql_matcher/helpers'
require 'rspec/sql_matcher/have_run_queries'
require 'rspec/sql_matcher/match_query'

RSpec.configure do |config|
  config.include RSpec::SqlMatcher::Helpers
end
