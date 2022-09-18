# RSpec match_structure

[![Ruby Gem](https://github.com/monade/rspec_sql_matcher/actions/workflows/gem-push.yml/badge.svg)](https://github.com/monade/rspec_sql_matcher/actions/workflows/gem-push.yml)

A gem to match SQL queries within your RSpec tests

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec_sql_matcher'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rspec_sql_matcher

## Usage

This gem defines a couple of matchers that can help to capture queries and check if they are correctly formatted.

Moreover, with the `RSpec::SqlMatcher::Helpers` module, it defines a set of helper methods to capture data from queries executed inside theirs blocks.

### have_run_queries
`have_run_queries` can match if a query has been run inside a block. For instance:

```ruby
expect { YourJob.perform_now }.to have_run_queries
```

It accepts various options:

```ruby
expect { YourJob.perform_now }.to have_run_queries(exactly: 2)
expect { YourJob.perform_now }.to have_run_queries(min: 2, max: 5)
```

### match_query
`match_query` can match query content using regular expressions. For instance:

```ruby
expect { User.very_complex_scope }.to match_query(/ GROUP BY "users"."id"/)
```

To see all the various features please refer to the [spec file](https://github.com/monade/rspec_sql_matcher/blob/main/rspec_sql_matcher).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/monade/rspec_sql_matcher.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

About Monade
----------------

![monade](https://monade.io/wp-content/uploads/2021/06/monadelogo.png)

your_gem_name is maintained by [mònade srl](https://monade.io/en/home-en/).

We <3 open source software. [Contact us](https://monade.io/en/contact-us/) for your next project!
