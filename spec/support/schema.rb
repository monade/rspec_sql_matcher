# frozen_string_literal: true

require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

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
