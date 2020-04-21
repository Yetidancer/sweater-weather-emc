class Api::V1::RoadTripController < ApplicationController
  def show
    if User.find_by(api_key: params[:api_key]) && MapsService.new.get_directions(params[:origin], params[:destination])[:status] == "OK"
      road_trip = RoadTrip.new(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(road_trip)
    elsif MapsService.new.get_directions(params[:origin], params[:destination])[:status] == "OK"
      render json: {error: 'Wrong API Key!!! You hate to see it.'}, status: 401
    else
      render json: {error: 'No route between origin and destination!!! You hate to see it.'}, status: 401
    end
  end
end
