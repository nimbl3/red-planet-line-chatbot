module RedPlanet
  class AllPromotionService < BaseService
    def initialize
      @http_query = {}
    end

    private

    def parse_response
      http_response.parsed_response['data']
    end

    def path_name
      '/promotion'
    end
  end
end
