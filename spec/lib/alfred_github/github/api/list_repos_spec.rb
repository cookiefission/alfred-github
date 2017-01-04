require 'alfred_github/github/api/list_repos'

module AlfredGithub
  class Github
    module Api
      RSpec.describe ListRepos do
        describe '.for' do
          subject(:list) { ListRepos.for(credentials, path) }

          let(:credentials) { Credentials.new(credentials_hash) }
          let(:credentials_hash) do
            {
              'url' => 'https://api.github.com',
              'token' => token
            }
          end
          let(:token) { 'foobar' }
          let(:path) { '/user/repos' }

          context 'when the response is good' do
            it 'returns all the repositories' do
              expect(list.count).to eq(2)
            end

            it 'wraps the returned repositories in Repository' do
              expect(list).to all(be_an_instance_of(Repository))
            end
          end

          context 'when the response is bad' do
            let(:token) { 'badtoken' }

            it 'returns only the error response' do
              expect(list.count).to eq(1)
            end

            it 'returns an error response' do
              expect(list).to all(be_an_instance_of(ErrorResponse))
            end
          end
        end
      end
    end
  end
end
