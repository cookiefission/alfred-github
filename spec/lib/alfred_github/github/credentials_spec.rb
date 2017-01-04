require 'alfred_github/github/credentials'

module AlfredGithub
  class Github
    RSpec.describe Credentials do
      let(:credentials) { Credentials.new(credentials_hash) }
      let(:credentials_hash) do
        {
          'url' => 'https://api.github.com',
          'token' => 'foobar'
        }
      end

      describe '#base_url' do
        it 'returns the expected url' do
          expect(credentials.base_url).to eq('https://api.github.com')
        end
      end

      describe '#token' do
        it 'returns the expected token' do
          expect(credentials.token).to eq('foobar')
        end
      end
    end
  end
end
