module AlfredGithub
  class Github
    module Api
      module Headers
        class Link

          attr_reader :header
          private :header

          def initialize(header)
            @header = header
          end

          def self.next_page(header)
            new(header).next_page
          end

          def next_page
            raw_links.select { |link| link.first == 'next' }.first.to_a.last
          end

          private

          def raw_links
            header.split(',').map do |raw_link|
              _, link, rel = /<(.+)>;\s*rel="(.+)"/.match(raw_link.strip).to_a
              [rel, link]
            end
          end

        end
      end
    end
  end
end
