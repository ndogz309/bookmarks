class LinkSerializer < ActiveModel::Serializer
  attributes :id, :url, :title, :html
end
