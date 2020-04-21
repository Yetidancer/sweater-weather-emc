class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location_data, :current, :hourly, :daily
end
