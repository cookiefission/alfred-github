require 'alfred-github/instances'
require 'alfred-github/repositories'
require 'alfred-github/github/api/list_repos'
require 'json'

module AlfredGithub
  class Github

    def self.rebuild_repositories
      new.rebuild_repositories
    end

    def rebuild_repositories
      instances.each do |instance|
        all_repositories.concat(repos_for_instance(instance))
      end

      write_repositories
    end

    private

    def all_repositories
      @all_repositories ||= JsonArray.new
    end

    def instances
      Instances.all
    end

    def repos_for_instance(instance)
      Api::ListRepos.for(instance, '/user/repos')
    end

    def write_repositories
      Repositories.write(all_repositories)
    end

    class JsonArray < Array
      def to_json
        map { |thing| thing.to_hash }.to_json
      end
    end

  end
end
