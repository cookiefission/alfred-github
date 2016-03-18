require 'alfred-github/github/credentials'
require 'json'

module AlfredGithub
  class Instances

    def self.all
      new.all
    end

    def all
      instances_hashes.map do |instance|
        Github::Credentials.new(instance)
      end
    end

    private

    def instances_hashes
      JSON.parse(instances_json)
    end

    def instances_json
      IO.read(instances_file)
    end

    def instances_file
      ENV['INSTANCES_FILE'] or
        File.dirname(__FILE__) + '/../../data/instances.json'
    end

  end
end
