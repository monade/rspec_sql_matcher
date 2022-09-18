# frozen_string_literal: true

RSpec::Matchers.define :match_query do |regexp|
  match(notify_expectation_failures: true) do |block|
    include RSpec::SqlMatcher::Helpers
    @queries = collect_queries(&block).map do |data|
      query = data[:sql].dup
      data[:binds].each_with_index { |bind, index| query.gsub!("\$#{index + 1}", bind.value.inspect) }
      query
    end

    @queries.any? { |query| regexp =~ query }
  end

  supports_block_expectations

  failure_message do |_|
    "Expected { } to match query with #{regexp}, but it didn't. Current queries where:\n#{@queries.join("\n")}:"
  end

  failure_message_when_negated do |_|
    "Expected { } not to match query with #{regexp}, but it did. Current queries where:\n#{@queries.join("\n")}:"
  end
end
