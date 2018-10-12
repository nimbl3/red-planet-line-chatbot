module RedPlanet
  class ShowPromotionService < BaseService
    attr_reader :promo_code

    def initialize(promo_code)
      @http_query = {}
      @promo_code = promo_code
    end

    def request_path
      [['https://api-staging.redplanethotels.com/v1', path_name, '/', promo_code].join, http_query.to_query].join('?'.freeze)
    end

    private

    def parse_response
      http_response.parsed_response['data']
    end

    def path_name
      '/hotel/flash'
    end
  end
end
