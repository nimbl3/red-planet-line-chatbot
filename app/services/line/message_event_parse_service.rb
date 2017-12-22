module Line
  class MessageEventParseService
    def initialize(body:, client:)
      @body = body
      @client = client
    end

    def call!
      client.parse_events_from(body)
    end

    private

    attr_reader :body, :client
  end
end
