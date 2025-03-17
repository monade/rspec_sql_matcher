# frozen_string_literal: true

require_relative 'lib/rspec/sql_matcher/version'

Gem::Specification.new do |spec|
  spec.name          = 'rspec_sql_matcher'
  spec.version       = RSpec::SqlMatcher::VERSION
  spec.authors       = ['Mònade']
  spec.email         = ['hello@monade.io']

  spec.summary       = 'An RSpec matcher to check SQL queries'
  spec.description   = 'An RSpec matcher to check SQL queries'
  spec.homepage      = 'https://github.com/monade/rspec_sql_matcher'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.1'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = 'https://github.com/monade/rspec_sql_matcher/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'activesupport', '>= 6.0', '< 9.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
