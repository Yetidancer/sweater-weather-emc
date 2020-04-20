class LocationDataSerializer
  include FastJsonapi::ObjectSerializer
  attributes :city, :state, :country

  attribute :current do |object|
    object.current.as_json
  end
  attribute :hourlies do |object|
    object.hourlies.as_json
  end
  attribute :dailies do |object|
    object.dailies.as_json
  end
end
