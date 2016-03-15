require 'alfred-github/repositories'

module AlfredGithub
  RSpec.describe Repositories do
    describe '.find_for' do
      subject(:find) { Repositories.find_for(query) }

      let(:query) { '' }

      context 'when the query is empty' do
        it 'returns all the repositories' do
          expect(find.count).to eql(2)
        end

        it 'wraps the repos in a Repository object' do
          expect(find).to all(be_an_instance_of(Repository))
        end
      end

      context 'when the query matches one repository' do
        let(:query) { 'foo' }

        it 'returns only that repository' do
          expect(find.count).to eql(1)
        end
      end

      context 'when the query matches no repositories' do
        let(:query) { 'bax' }

        it 'returns an empty array' do
          expect(find.count).to eql(0)
        end
      end
    end
  end
end
