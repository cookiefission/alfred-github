require 'net/https'

module AlfredGithub
  class Github
    module Api

      ApiError = Class.new(StandardError)

      class Get

        attr_reader :credentials, :path, :params
        private :credentials, :path, :params

        def initialize(credentials, path, params = {})
          @credentials, @path, @params = credentials, path, params
        end

        def parsed_response
          fail(ApiError, error_message) unless success?

          JSON.parse(response.body)
        end

        def success?
          response_code == 200
        end

        private

        def error_message
          JSON.parse(response.body)['message']
        end

        def response_code
          response.code.to_i
        end

        def response
          Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
            http.request(request)
          end
        end

        def request
          Net::HTTP::Get.new(uri.request_uri).tap do |request|
            request['Accept'] = 'application/vnd.github.v3+json'
            request['Authorization'] = "token #{credentials.token}"
          end
        end

        def uri
          @uri ||= URI("#{credentials.base_url}#{path}#{query_string}")
        end

        def query_string
          if params.any?
            '?' + params.map {|k, v| "#{CGI.escape k}=#{CGI.escape v}"}.join("&")
          else
            ''
          end
        end

      end
    end
  end
end
