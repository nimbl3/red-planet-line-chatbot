module RedPlanet
  class BaseService
    include HTTParty

    attr_reader :parsed_response

    delegate :code, :body, to: :http_response, prefix: true

    def call!
      @http_response = send_request
      # raise(Pathfinder::Errors::RedPlanetError, @http_response.body) unless successful_response?

      @parsed_response = parse_response
    end

    def request_path
      [['https://api-staging.redplanethotels.com/v1', path_name].join, http_query.to_query].join('?'.freeze)
    end

    def request_body
      ''
    end

    def successful_response?
      @http_response.success?
    end

    private

    attr_reader :http_response, :http_query

    def send_request
      self.class.get(request_path, format: :json)
    end
  end
end