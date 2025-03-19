# frozen_string_literal: true

require 'active_record'

if ENV['ACTIVE_RECORD_ADAPTER'] == 'mysql'
  puts 'Running on MySQL...'
  ActiveRecord::Base.establish_connection(
    adapter: 'mysql2',
    host: ENV['DB_HOST'] || '127.0.0.1',
    username: ENV['DB_USERNAME'] || 'root',
    password: ENV['DB_PASSWORD'],
    database: ENV['DB_NAME']
  )
elsif ENV['ACTIVE_RECORD_ADAPTER'] == 'postgresql'
  puts 'Running on PostgreSQL...'
  ActiveRecord::Base.establish_connection(
    adapter: 'postgresql',
    database: ENV['DB_NAME'],
    host: ENV['DB_HOST'] || '127.0.0.1',
    username: ENV['DB_USERNAME'] || ENV['POSTGRES_USER'] || 'postgres',
    password: ENV['DB_PASSWORD'] || ENV['POSTGRES_PASSWORD']
  )
else
  puts 'Running on SQLite...'
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: ':memory:'
  )
end

class Book < ActiveRecord::Base
  after_initialize do
    self.title = 'The Book'
    self.author = 'The Author'
  end
end

module Schema
  def self.create
    ActiveRecord::Migration.verbose = false

    ActiveRecord::Schema.define do
      create_table :books, force: true do |t|
        t.string :title
        t.string :author

        t.timestamps null: false
      end
    end
  end
end
