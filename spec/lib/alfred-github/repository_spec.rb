require 'alfred-github/repository'

module AlfredGithub
  RSpec.describe Repository do
    let(:repo) { Repository.new(data) }
    let(:data) {
      {
        'full_name' => 'foo/bar',
        'html_url' => 'https://github.com/foo/bar',
        'some_key' => 'does not matter',
      }
    }

    describe '#name' do
      it 'returns the full_name of the response' do
        expect(repo.name).to eq('foo/bar')
      end
    end

    describe '#url' do
      it 'returns the html_url of the response' do
        expect(repo.url).to eq('https://github.com/foo/bar')
      end
    end

    describe '#to_hash' do
      let(:expected_hash) {
        {
          'full_name' => 'foo/bar',
          'html_url' => 'https://github.com/foo/bar',
        }
      }

      it 'returns only the required fields for storage' do
        expect(repo.to_hash).to eq(expected_hash)
      end
    end
  end
end
