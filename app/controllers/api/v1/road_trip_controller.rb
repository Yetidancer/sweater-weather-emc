class Api::V1::RoadTripController < ApplicationController
  def show
    directions = MapsService.new.get_directions(params[:origin], params[:destination])
    if User.find_by(api_key: params[:api_key]) && directions[:status] == "OK"
      road_trip = RoadTrip.new(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(road_trip)
    elsif directions[:status] == "OK"
      render json: {error: 'Wrong API Key!!! You hate to see it.'}, status: 401
    else
      render json: {error: 'No route between origin and destination!!! You hate to see it.'}, status: 401
    end
  end
end
