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

    def type
      case
      when private?
        'private'
      when fork?
        'fork'
      when mirror?
        'mirror'
      else
        'repo'
      end
    end

    private

    def private?
      data.fetch('private', false) == true
    end

    def fork?
      data.fetch('fork', false) == true
    end

    def mirror?
      !data['mirror_url'].nil?
    end

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
