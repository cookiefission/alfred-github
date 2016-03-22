require 'alfred-github/instances'
require 'json'

module AlfredGithub
  RSpec.describe Instances do
    describe '.all' do
      subject(:instances) { Instances.all }

      context 'when instances file exists' do
        it 'returns all the instances' do
          expect(instances.count).to eql(1)
        end

        it 'wraps the instances in a credentials object' do
          expect(instances).to all(be_an_instance_of(Github::Credentials))
        end
      end
    end
  end
end
