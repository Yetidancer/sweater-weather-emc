# Sweater Weather

This API provides endpoints in conjunction with a front-end application designed to plan road trips around origin and destination weather forecasts.

## Endpoints:
#### Forecast
`GET 'api/v1/forecast'`

*parameters:* `location`

- gets the current, hourly and daily forecast for a certain location.

#### Background Image
`GET 'api/v1/background'`

*parameters:* `location`

- returns image that fits current location and weather.

#### Register User
`POST 'api/v1/users'`

- registers a new user using a unique email and password. Returns an API key specific to the user in the response.

*request body:*
```
{
  email: <user email>
  password: <password>
  password_confirmation: <password>
}
```

#### Log In
`POST 'api/v1/sessions'`

- logs a user into a session, authenticating using their password. Response includes user's unique API key.

*request body:*
```
{
  email: <user email>
  password: <password>
}
```

#### Road Trip
`POST 'api/v1/road_trip'`

- provides origin and destination weather and travel time. Requires user API key.

*request body:*
```
{
  origin: <origin point>
  destination: <destination point>
  api_key: <user api key>
}
```

### Requires keys from the below:
- [Google Maps API](https://developers.google.com/maps/documentation/javascript/get-api-key)
- [Openweather API](https://openweathermap.org/api/one-call-api)
- [Unsplash API](https://unsplash.com/developers)

To install, obtain keys from all three of the above, then run ```bundle exec figaro install```, then copy your keys into the ```configs/application.yml``` file:

```
GOOGLE_API_KEY: <your API key here>
OPEN_WEATHER_API_KEY: <your API key here>
SPLASH_API_KEY: <your API key here>
```

### Creator:
[Ezekiel Clark](https://github.com/Yetidancer/)
