# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
RSpec.describe RSpec::SqlMatcher do
  # rubocop:enable Metrics/BlockLength

  it '#have_run_queries' do
    expect do
      Book.create!
    end.to have_run_queries
  end

  it '#have_run_queries(max: _)' do
    Book.create!
    expect do
      Book.create!
      Book.all
    end.to have_run_queries(max: 2)

    expect do
      Book.create!
      Book.first
      Book.destroy_all
    end.not_to have_run_queries(max: 2)
  end

  it '#have_run_queries(min: _)' do
    Book.create!
    expect do
      Book.first
    end.not_to have_run_queries(min: 2)

    expect do
      Book.first
      Book.count
      Book.count
    end.to have_run_queries(min: 2)
  end

  it '#have_run_queries(min: _, max: _)' do
    Book.create!
    expect do
      Book.first
      Book.first
      Book.first
    end.to have_run_queries(min: 2, max: 5)

    expect do
      Book.first
    end.not_to have_run_queries(min: 2, max: 5)

    expect do
      Book.first
      Book.first
      Book.first
      Book.first
      Book.first
      Book.first
    end.not_to have_run_queries(min: 2, max: 5)
  end

  it '#have_run_queries(exactly: _)' do
    Book.create!
    expect do
      Book.first
    end.not_to have_run_queries(exactly: 2)

    expect do
      Book.first
      Book.count
    end.to have_run_queries(exactly: 2)
  end
end
