class PartnerSerializer < ActiveModel::Serializer
  attributes :id

  def attributes(*args)
    hash = super
    hash.merge(object.attributes.symbolize_keys)
  end

  has_many :residences
end

class ResidenceSerializer < ActiveModel::Serializer
  attributes :id
  def attributes(*args)
    hash = super
    hash.merge(object.attributes.symbolize_keys)
  end
  has_many :blocks
  has_many :rooms
  has_many :addresses
end

class BlockSerializer < ActiveModel::Serializer
  attributes :id
  def attributes(*args)
    hash = super
    hash.merge(object.attributes.symbolize_keys)
  end
  has_many :sub_blocks
  has_many :rooms
  has_many :addresses
end

class SubBlockSerializer < ActiveModel::Serializer
  attributes :id
  def attributes(*args)
    hash = super
    hash.merge(object.attributes.symbolize_keys)
  end
  has_many :rooms
  has_many :addresses
end

class RoomSerializer < ActiveModel::Serializer
  attributes :id
  def attributes(*args)
    hash = super
    hash.merge(object.attributes.symbolize_keys)
  end
end
class AddressSerializer < ActiveModel::Serializer
  attributes :id
  def attributes(*args)
    hash = super
    hash.merge(object.attributes.symbolize_keys)
  end
end