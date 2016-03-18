require 'alfred-github/github/api/get'
require 'alfred-github/repository'
require 'alfred-github/error_response'

module AlfredGithub
  class Github
    module Api
      class ListRepos

        attr_reader :credentials, :path
        private :credentials, :path

        def initialize(credentials, path)
          @credentials, @path = credentials, path
        end

        def self.for(credentials, path)
          new(credentials, path).response
        end

        def response
          request.parsed_response.map do |repo|
            Repository.new(repo)
          end

        rescue ApiError => e
          [ ErrorResponse.new(e.message) ]
        end

        private

        def request
          Get.new(credentials, path)
        end

      end
    end
  end
end
