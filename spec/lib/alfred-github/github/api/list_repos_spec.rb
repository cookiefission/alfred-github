require 'alfred-github/github/api/list_repos'

module AlfredGithub
  class Github
    module Api
      RSpec.describe ListRepos do
        describe '.for' do
          subject(:list) { ListRepos.for(credentials, path) }

          let(:credentials) { Credentials.new(credentials_hash) }
          let(:credentials_hash) {
            {
              'url' => 'https://api.github.com',
              'token' => token,
            }
          }
          let(:token) { 'foobar' }
          let(:path) { '/user/repos' }

          context 'when the response is good' do
            it 'returns all the repositories' do
              expect(list.count).to eq(1)
            end

            it 'wraps the returned repositories in Repository' do
              expect(list).to all(be_an_instance_of(Repository))
            end
          end

          context 'when the response is bad' do
            xit 'returns a error repository' do

            end
          end
        end
      end
    end
  end
end
