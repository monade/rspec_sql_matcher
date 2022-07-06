# frozen_string_literal: true

require_relative "rspec_sql_matcher/version"
require 'active_support/core_ext/hash'

include Structure::Type::Methods

def log_queries
  instance = ActiveSupport::Notifications.subscribe 'sql.active_record' do |_, _, _, _, data|
    puts
    binds = data[:binds].map { |e| "#{e.name} => #{e.value}" }.join(', ')
    puts "#{data[:sql]} | #{binds}"
    puts
    puts
  end
  yield
ensure
  ActiveSupport::Notifications.unsubscribe(instance) if instance
end

RSpec::Matchers.define :run_query_count do |count|
  match(notify_expectation_failures: true) do |block|
    @real_count = 0
    notification = ActiveSupport::Notifications.subscribe 'sql.active_record' do |_, _, _, _, data|
      @real_count == count
    end
    block.call

    @real_count == count
  ensure
    ActiveSupport::Notifications.unsubscribe(notification) if notification
  end

  supports_block_expectations

  failure_message do |_|
    "Expected { } to execute #{count} queries, but there were #{@real_count} instead."
  end

  failure_message_when_negated do |_|
    "Expected { } not to execute #{count} queries, but it did."
  end
end

RSpec::Matchers.define :match_query do |regexp|
  match(notify_expectation_failures: true) do |block|
    @queries = []
    notification = ActiveSupport::Notifications.subscribe 'sql.active_record' do |_, _, _, _, data|
      query = data[:sql].dup
      data[:binds].each_with_index { |bind, index| query.gsub!("\$#{index + 1}", bind.value.inspect) }
      @queries << query
    end
    block.call

    @queries.any? { |q| regexp =~ q }
  ensure
    ActiveSupport::Notifications.unsubscribe(notification) if notification
  end

  supports_block_expectations

  failure_message do |_|
    "Expected { } to match query with #{regexp}, but it didn't. Current queries where:\n#{@queries.join("\n")}:"
  end

  failure_message_when_negated do |_|
    "Expected { } not to match query with #{regexp}, but it did. Current queries where:\n#{@queries.join("\n")}:"
  end
end
