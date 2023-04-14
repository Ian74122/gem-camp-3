class ProvinceSerializer < ActiveModel::Serializer
  attributes :id, :region, :name
  # attributes :id, :region, :name, :region_name, :status, :region
  # belongs_to :region
  #
  def region
    object.region.name
  end

  # def region
  #   RegionSerializer.new(object.region)
  # end
  #
  # def status
  #   'hi'
  # end
end