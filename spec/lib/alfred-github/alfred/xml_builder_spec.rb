require 'alfred-github/alfred/xml_builder'

module AlfredGithub
  class Alfred
    RSpec.describe XmlBuilder do
      describe '.for' do
        subject(:xml) { XmlBuilder.for(repositories) }

        let(:repositories) {
          [
            repository
          ]
        }
        let(:repository) {
          double(
            'Repository',
            name: 'foo/bar',
            url: url
          )
        }
        let(:url) { 'https://github.com/foo/bar' }

        context 'when given one repository' do
          let(:expected_xml) {
            <<-XML
<?xml version="1.0"?>
<items>
  <item uid="#{url}" arg="#{url}" valid="yes">
    <title>foo/bar</title>
    <subtitle>#{url}</subtitle>
    <icon>icon.png</icon>
  </item>
</items>
            XML
          }

          it 'returns the correct xml' do
            expect(xml).to eq(expected_xml)
          end
        end

        context 'when given multiple repositories' do
          let(:repositories) {
            [
              repository,
              repository,
            ]
          }
          let(:expected_xml) {
            <<-XML
<?xml version="1.0"?>
<items>
  <item uid="#{url}" arg="#{url}" valid="yes">
    <title>foo/bar</title>
    <subtitle>#{url}</subtitle>
    <icon>icon.png</icon>
  </item>
  <item uid="#{url}" arg="#{url}" valid="yes">
    <title>foo/bar</title>
    <subtitle>#{url}</subtitle>
    <icon>icon.png</icon>
  </item>
</items>
            XML
          }

          it 'returns the correct xml' do
            expect(xml).to eq(expected_xml)
          end
        end

        context 'when given no repositories' do
          let(:repositories) { [] }
          let(:expected_xml) {
            <<-XML
<?xml version="1.0"?>
<items>
</items>
            XML
          }

          it 'returns the correct xml' do
            expect(xml).to eq(expected_xml)
          end
        end
      end
    end
  end
end
