require 'alfred-github/github/api/get'
require 'alfred-github/github/credentials'

module AlfredGithub
  class Github
    module Api
      RSpec.describe Get do
        describe '#parsed_response' do
          subject(:parsed_response) { request.parsed_response }

          let(:request) { Get.new(credentials, path, params) }
          let(:credentials) { Credentials.new(credentials_hash) }
          let(:credentials_hash) {
            {
              'url' => 'https://api.github.com',
              'token' => token,
            }
          }
          let(:token) { 'foobar' }
          let(:path) { '/user/repos' }
          let(:params) { {} }

          context 'when the response is good' do
            let(:expected_response) { Spec::ExampleData.user_repos }

            it 'returns the parsed json response' do
              expect(parsed_response).to eql(expected_response)
            end
          end

          context 'when the response is bad' do
            let(:token) { 'badtoken' }

            it 'raises an api error' do
              expect { parsed_response }.to raise_error(
                ApiError,
                'Bad credentials',
              )
            end
          end
        end
      end
    end
  end
end
