ENV['REPOS_FILE'] = File.dirname(__FILE__) + '/support/repositories.json'
ENV['INSTANCES_FILE'] = File.dirname(__FILE__) + '/support/instances.json'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.disable_monkey_patching!

  config.warnings = true

  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed
end

require 'support/webmock'
require 'support/example_data'
