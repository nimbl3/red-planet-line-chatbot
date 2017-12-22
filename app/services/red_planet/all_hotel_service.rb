module RedPlanet
  class AllHotelService < BaseService
    def initialize
      @http_query = {}
    end

    private

    def parse_response
      http_response.parsed_response['data']
    end

    def path_name
      '/hotel_location'
    end
  end
end