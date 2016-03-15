require 'alfred-github/alfred'

module AlfredGithub
  RSpec.describe Alfred do
    describe '.search' do
      subject(:search) { Alfred.search(query) }

      let(:query) { 'foo' }
      let(:xml_string) { double('xml string') }
      let(:repositories) { double('repositories') }

      before do
        allow(Alfred::XmlBuilder).to receive(:for).and_return(xml_string)
        allow(Repositories).to receive(:find_for).and_return(repositories)
      end

      it 'delegates finding' do
        expect(Repositories).to receive(:find_for).
          with(query).
          and_return(repositories)

        search
      end

      it 'delegates rendering' do
        expect(Alfred::XmlBuilder).to receive(:for).
          with(repositories).
          and_return(xml_string)

        search
      end
    end
  end
end
