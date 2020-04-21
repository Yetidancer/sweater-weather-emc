class Api::V1::RoadTripController < ApplicationController
  def show
    if User.find_by(api_key: params[:api_key])
      road_trip = RoadTrip.new(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(road_trip)
    else
      render json: {error: 'Wrong API Key!!! You hate to see it.'}, status: 401
    end
  end
end
