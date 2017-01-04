require 'erb'

module AlfredGithub
  class Alfred
    class XmlBuilder
      attr_reader :repositories
      private :repositories

      def initialize(repositories)
        @repositories = repositories
      end

      def self.for(repositories)
        new(repositories).build
      end

      def build
        erb.result(binding)
      end

      private

      def erb
        ERB.new(template)
      end

      def template
        IO.read(template_file)
      end

      def template_file
        File.dirname(__FILE__) + '/items.xml.erb'
      end
    end
  end
end
