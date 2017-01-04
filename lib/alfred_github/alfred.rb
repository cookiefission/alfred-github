require 'alfred_github/alfred/xml_builder'
require 'alfred_github/repositories'

module AlfredGithub
  class Alfred
    attr_reader :query
    private :query

    def initialize(query)
      @query = query
    end

    def self.search(query)
      new(query).search
    end

    def search
      XmlBuilder.for(repositories)
    end

    private

    def repositories
      Repositories.find_for(query)
    end
  end
end
