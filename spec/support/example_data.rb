require 'json'

module Spec
  module ExampleData
    module_function

    def user_repos
      parsed_fixture('user-repos.json')
        .concat(parsed_fixture('user-repos-page-2.json'))
    end

    def parsed_fixture(file)
      _, json = fixture(file).split("\n\n")

      JSON.parse(json)
    end

    def fixture(file)
      IO.read("#{Dir.pwd}/spec/fixtures/#{file}")
    end
  end
end
