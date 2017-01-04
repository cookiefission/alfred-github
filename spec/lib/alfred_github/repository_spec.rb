require 'alfred_github/repository'

module AlfredGithub
  RSpec.describe Repository do
    let(:repo) { Repository.new(data) }
    let(:data) do
      {
        'full_name' => 'foo/bar',
        'html_url' => 'https://github.com/foo/bar',
        'private' => private?,
        'fork' => fork?,
        'mirror_url' => mirror_url,
        'some_key' => 'does not matter'
      }
    end
    let(:private?) { false }
    let(:fork?) { false }
    let(:mirror_url) { nil }

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

    describe '#type' do
      subject(:type) { repo.type }

      it { is_expected.to eq('repo') }

      context 'when it is private' do
        let(:private?) { true }

        it { is_expected.to eq('private') }
      end

      context 'when it is a fork' do
        let(:fork?) { true }

        it { is_expected.to eq('fork') }
      end

      context 'when it is a mirror' do
        let(:mirror_url) { 'example.com' }

        it { is_expected.to eq('mirror') }
      end
    end

    describe '#to_hash' do
      let(:expected_hash) do
        {
          'full_name' => 'foo/bar',
          'html_url' => 'https://github.com/foo/bar',
          'private' => false,
          'fork' => false,
          'mirror_url' => nil
        }
      end

      it 'returns only the required fields for storage' do
        expect(repo.to_hash).to eq(expected_hash)
      end
    end
  end
end
