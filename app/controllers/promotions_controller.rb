class PromotionsController < ApplicationController
  before_action :set_promotion, only: [:show]

  # GET /promotions/1
  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_promotion
    @promotion = RedPlanet::ShowPromotionService.new(params[:id]).call!
  end
end
