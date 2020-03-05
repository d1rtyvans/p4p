class ResortSerializer < ActiveModel::Serializer
  attributes :id,
             :uid,
             :name,
             :coords
end
