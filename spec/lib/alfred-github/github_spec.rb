require 'alfred-github/github'

module AlfredGithub
  RSpec.describe Github do
    describe '.rebuild_repositories' do
      subject(:rebuild) { Github.rebuild_repositories }

      before(:all) do
        @original_repos_file = ENV['REPOS_FILE']
        ENV['REPOS_FILE'] = '/tmp/alfred_github_repos_test.json'
      end

      after(:all) do
        File.delete(ENV['REPOS_FILE'])
        ENV['REPOS_FILE'] = @original_repos_file
      end

      before do
        File.open(ENV['REPOS_FILE'], 'w') do |file|
          file.write([].to_json)
        end
      end

      let(:expected_repositories) {
        [
          {
            'full_name' => 'cookiefission/alfred-github',
            'html_url' => 'https://github.com/cookiefission/alfred-github'
          }
        ]
      }

      it 'rebuilds the repositories file' do
        expect { rebuild }.to change {
          File.read(ENV['REPOS_FILE'])
        }
      end

      it 'writes the correct data to the repositories file' do
        rebuild

        expect(
          JSON.parse(File.read(ENV['REPOS_FILE']))
        ).to eq(expected_repositories)
      end
    end
  end
end
