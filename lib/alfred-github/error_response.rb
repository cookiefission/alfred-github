module AlfredGithub
  class ErrorResponse

    attr_reader :message
    alias_method :url, :message

    def initialize(message = '')
      @message = message.to_s
    end

    def name
      'There was an error'
    end

  end
end
