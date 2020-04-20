class DailySerializer
  include FastJsonapi::ObjectSerializer
  attributes :day, :icon, :description, :precipitation, :high, :low
end
