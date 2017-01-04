require 'alfred_github/error_response'

module AlfredGithub
  RSpec.describe ErrorResponse do
    let(:error) { ErrorResponse.new(message) }
    let(:message) { 'Fuckkkkkkkk' }

    describe '#name' do
      subject { error.name }

      it { is_expected.to eq('There was an error') }
    end

    describe '#url' do
      subject { error.url }

      it { is_expected.to eq(message) }
    end
  end
end
