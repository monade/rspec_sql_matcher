# frozen_string_literal: true

RSpec.describe RSpec::SqlMatcher do
  context '#match_query' do
    it 'matches the executed query with a regexp' do
      expect do
        Book.where(title: 'cool').first
      end.to match_query(/FROM "books" WHERE "books"."title" = ?/)
    end

    it 'matches at least a query within a group' do
      expect do
        Book.all.to_a
        Book.where(title: 'cool').first
      end.to match_query(/WHERE "books"."title"/)
    end

    it 'works with negation' do
      expect do
        Book.all.to_a
      end.not_to match_query(/WHERE/)
    end
  end
end
