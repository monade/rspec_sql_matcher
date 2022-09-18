# frozen_string_literal: true

module RSpec
  module SqlMatcher
    module Helpers
      def count_queries(&block)
        count = 0
        _record_sql_queries(->(_) { count += 1 }, &block)
        count
      end

      def collect_queries(&block)
        queries = []
        _record_sql_queries(->(query) { queries << query }, &block)
        queries
      end

      def log_queries(&block)
        _record_sql_queries(
          lambda { |data|
            puts
            binds = data[:binds].map { |e| "#{e.name} => #{e.value}" }.join(', ')
            puts "#{data[:sql]} | #{binds}"
            puts
            puts
          }, &block
        )
      end

      private

      def _record_sql_queries(callback)
        instance = ActiveSupport::Notifications.subscribe 'sql.active_record' do |_, _, _, _, data|
          callback.call(data)
        end
        yield
      ensure
        ActiveSupport::Notifications.unsubscribe(instance) if instance
      end
    end
  end
end
