class Api::V1::RegionsController < ApplicationController
  def index
    regions = Address::Region.all
    render json: regions
  end

  def show
    render json: Address::Region.find(params[:id])
  end
end
