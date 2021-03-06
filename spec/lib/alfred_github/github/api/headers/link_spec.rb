require 'alfred_github/github/api/headers/link'

module AlfredGithub
  class Github
    module Api
      module Headers
        RSpec.describe Link do
          describe '.next_page' do
            subject(:next_page) { Link.next_page(header) }

            let(:header) do
              '<https://api.github.com/user/repos?page=3&per_page=100>; '\
                'rel="next", <https://api.github.com/user/repos?page=50'\
                '&per_page=100>; rel="last"'
            end
            let(:expected_next_page) do
              'https://api.github.com/user/repos?page=3&per_page=100'
            end

            context 'when the next page is present' do
              it { is_expected.to eq(expected_next_page) }
            end

            context 'when the next page is not present' do
              let(:header) do
                '<https://api.github.com/user/repos?page=50&per_page=100>;'\
                  ' rel="prev"'
              end
              it { is_expected.to be_nil }
            end
          end
        end
      end
    end
  end
end
