class FindPropertiesService
  attr_reader :properties

  def initialize(properties)
    @properties = properties
  end

  def call(params = {})
    scoped = properties
    scoped = filter_by_min_price(scoped, params[:min_price])
    scoped = filter_by_max_price(scoped, params[:max_price])
    scoped = filter_by_community_id(scoped, params[:community_id])
    filter_by_nro_rooms(scoped, params[:nro_rooms])
  end

  private


  def filter_by_min_price(scoped, min_price)
    return scoped unless min_price.present?

    scoped.where("price >= ?", min_price)
  end

  def filter_by_max_price(scoped, max_price)
    return scoped unless max_price.present?

    scoped.where("price <= ?", max_price)
  end

  def filter_by_community_id(scoped, community_id)
    return scoped unless community_id.present?

    scoped.where(community_id: community_id)
  end

  def filter_by_nro_rooms(scoped, nro_rooms)
    return scoped unless nro_rooms.present?

    scoped.where(nro_rooms: nro_rooms)
  end
end