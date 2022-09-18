# frozen_string_literal: true

module RSpec
  module SqlMatcher
    module HaveRunQueries
      def self.evaluate_expectation(count, options = {})
        condition = true
        condition &&= count >= options[:min] if options[:min]
        condition &&= count <= options[:max] if options[:max]
        condition &&= count == options[:exactly] if options[:exactly]

        condition
      end

      def self.failure_message(count, options = {})
        return "Expected { } to run #{options[:exactly]} queries, but there were #{count} instead." if options[:exactly]

        if options[:min] && options[:max]
          return "Expected { } to run a number of query between #{options[:min]} and #{options[:max]}, but there were #{count} instead."
        end

        if options[:min]
          return "Expected { } to run at least #{options[:min]} queries, but there were #{count} instead."
        end

        return "Expected { } to run at most #{options[:max]} queries, but there were #{count} instead." if options[:max]

        'Invalid expectation parameters. Please pass min, max or exactly.'
      end

      def self.failure_message_when_negated(_count, options = {})
        return "Expected { } not to execute #{options[:exactly]} queries, but it did." if options[:exactly]
        if options[:min] && options[:max]
          return "Expected { } not to run a number of query between #{options[:min]} and #{options[:max]}, but it did."
        end
        return "Expected { } not to run at least #{options[:min]} queries, but it did." if options[:min]

        return "Expected { } not to run at most #{options[:max]} queries, but it did." if options[:max]

        'Invalid expectation parameters. Please pass min, max or exactly.'
      end
    end
  end
end

RSpec::Matchers.define :have_run_queries do |options = { min: 1 }|
  match(notify_expectation_failures: true) do |block|
    include RSpec::SqlMatcher
    @real_count = count_queries(&block)

    RSpec::SqlMatcher::HaveRunQueries.evaluate_expectation(@real_count, options)
  end

  supports_block_expectations

  failure_message do |_|
    RSpec::SqlMatcher::HaveRunQueries.failure_message(@real_count, options)
  end

  failure_message_when_negated do |_|
    RSpec::SqlMatcher::HaveRunQueries.failure_message_when_negated(@real_count, options)
  end
end
