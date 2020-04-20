class CurrentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :temp, :high, :low, :description, :icon, :feels_like, :humidity, :visibility, :uv_index, :sunrise, :sunset
end
