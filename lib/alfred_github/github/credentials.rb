module AlfredGithub
  class Github
    class Credentials
      attr_reader :credentials_hash
      private :credentials_hash

      def initialize(credentials_hash)
        @credentials_hash = credentials_hash
      end

      def base_url
        credentials_hash.fetch('url')
      end

      def token
        credentials_hash.fetch('token')
      end
    end
  end
end
