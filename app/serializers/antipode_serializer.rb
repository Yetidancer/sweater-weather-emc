class AntipodeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location_name, :search_location

  attribute :forecast do |object|
    object.forecast.as_json.slice('summary', 'current_temperature')
  end
end
