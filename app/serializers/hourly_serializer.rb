class HourlySerializer
  include FastJsonapi::ObjectSerializer
  attributes :time, :temp, :icon
end
