class Api::V1::RegionsController < ApplicationController
  def index
    regions = Address::Region.all
    render json: regions, each_serializer: RegionSerializer
  end

  def show
    render json: Address::Region.find(params[:id]), serializer: RegionSerializer
  end
end
