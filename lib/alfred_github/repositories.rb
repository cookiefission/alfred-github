require 'alfred_github/repository'
require 'json'

module AlfredGithub
  class Repositories
    NotFound = Class.new(StandardError)

    def self.find_for(query)
      new.find(query)
    end

    def self.write(repositories)
      new.write(repositories)
    end

    def find(query)
      repositories.select { |repo| repo.name.include?(query) }
    end

    def write(repositories)
      File.open(repositories_file, 'w') do |file|
        file.write(repositories.to_json)
      end
    end

    private

    def repositories
      repository_hashes.map do |repo|
        Repository.new(repo)
      end

    rescue NotFound
      []
    end

    def repository_hashes
      JSON.parse(repositories_json).tap do |repos|
        repos.empty? && raise(NotFound)
      end
    end

    def repositories_json
      IO.read(repositories_file)
    rescue Errno::ENOENT
      raise NotFound
    end

    def repositories_file
      ENV['REPOS_FILE'] ||
        File.dirname(__FILE__) + '/../../data/repositories.json'
    end
  end
end
