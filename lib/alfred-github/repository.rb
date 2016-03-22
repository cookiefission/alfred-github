module AlfredGithub
  class Repository

    attr_reader :data
    private :data

    def initialize(data)
      @data = data
    end

    def to_hash
      data.select { |key, _| storage_keys.include?(key) }
    end

    def name
      data.fetch('full_name')
    end

    def url
      data.fetch('html_url')
    end

    private

    def storage_keys
      [
        'full_name',
        'html_url',
        'private',
        'fork',
        'mirror_url',
      ]
    end

  end
end
