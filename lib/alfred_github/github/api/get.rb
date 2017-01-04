require 'net/https'
require 'alfred_github/github/api/headers/link'

module AlfredGithub
  class Github
    module Api
      ApiError = Class.new(StandardError)

      class Get
        attr_reader :credentials, :path, :params
        private :credentials, :path, :params

        def initialize(credentials, path, params = {})
          @credentials = credentials
          @path = path
          @params = params
        end

        def parsed_response
          raise(ApiError, error_message) unless success?

          responses = Array(JSON.parse(response.body))
          next_page = Headers::Link.next_page(response['Link'])

          if next_page
            @uri = URI(next_page)
            responses.concat(parsed_response)
          end

          responses
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
            '?' + params.map { |k, v| "#{k}=#{v}" }.join('&')
          else
            ''
          end
        end
      end
    end
  end
end
