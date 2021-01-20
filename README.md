# README
<!-- Shields -->
![](https://img.shields.io/badge/Rails-5.2.4-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)
![](https://img.shields.io/badge/Ruby-2.5.3-orange)
![](https://img.shields.io/gem/v/fast_jsonapi)
![](https://img.shields.io/github/issues/sweater_weather)

# Sweater Weather
![Sweater Weather](https://user-images.githubusercontent.com/68172332/105113035-619ea500-5a81-11eb-904a-64ecfa505229.png)

## Table of Contents
  - [What it does](#what-it-does)
  - [How to Install Sweater Weather](#how-to-install-sweater-weather)
  - [API Contract](#api-contract)
  - [Schema](#schema)
  - [Dependencies](#dependencies)
  - [Testing](#testing)
  - [Learning Goals](#learning-goals)
  - [Licenses](#licenses)
  - [Contact](#contact)
  - [Acknowledgments](#acknowledgments)

## What it does

Sweater Weather simulates the workflow of a back-end developer in a full stack team using service-oriented architecture. The front-end team has provided API contracts for their needs, and Sweater Weather actualizes those contracts to create the API endpoints needed. Sweater Weather makes use of three external APIs: MapQuest, OpenWeather and Unsplash. The project processes these APIs and serializes the needed data into custom endpoints.

## How to Install Sweater Weather

For usage on your local machine follow the instructions listed below:

```
git git@github.com:nmking22/sweater_weather.git
cd sweater_weather
bundle install
rake db:{create,migrate}
figaro install
  #setup ENV variables in application.yml
    #MAPQUEST_KEY: <your_mapquest_key>
    #WEATHER_KEY: <your_openweather_key>
    #UNSPLASH_KEY: <your_unsplash_key>
rails s
get/post calls to: localhost:3000 in your web browser
```
Mapquest API keys are available [here](https://developer.mapquest.com/documentation/)

OpenWeather API keys (One Call API) are available [here](https://openweathermap.org/api)

Unsplash API keys are available [here](https://unsplash.com/documentation#creating-a-developer-account)

## API Contract

### GET /api/v1/forecast?location={location}
  
Returns current weather forecast, hourly forecast for the next 8 hours and daily forecast for the next 5 days at queried location

#### Sample Request

```
GET /api/v1/forecast?location=denver,co
Content-Type: application/json
Accept: application/json
```

#### Sample Response

```
{
  "data": {
    "id": 'null',
    "type": "forecast",
    "attributes": {
      "current_weather": {
        "datetime": "2020-09-30 13:27:03 -0600",
        "temperature": 79.4,
        etc
      },
      "daily_weather": [
        {
          "date": "2020-10-01",
          "sunrise": "2020-10-01 06:10:43 -0600",
          etc
        },
        {...} etc
      ],
      "hourly_weather": [
        {
          "time": "14:00:00",
          "wind_speed": "4 mph",
          "wind_direction": "from NW",
          etc
        },
        {...} etc
      ]
    }
  }
}
```
  
### GET /api/v1/backgrounds?location={location}
  
Returns a relevant image for the queried location

#### Sample Request

```
GET /api/v1/backgrounds?location=denver,co
Content-Type: application/json
Accept: application/json
```

#### Sample Response

```
status: 200
body:

{
  "data": {
    "type": "image",
    "id": null,
    "attributes": {
      "image": {
        "location": "denver,co",
        "image_url": "https://pixabay.com/get/54e6d4444f50a814f1dc8460962930761c38d6ed534c704c7c2878dd954dc451_640.jpg",
        "credit": {
          "source": "pixabay.com",
          "author": "quinntheislander",
          "logo": "https://pixabay.com/static/img/logo_square.png"
        }
      }
    }
  }
}
```
  
### POST /api/v1/users

Creates a user in BE database and returns user's email and a unique API key. Parameters should be sent as a JSON payload in the body of the request for this response.

#### Sample Request

```
POST /api/v1/users
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```

#### Sample Response

```
status: 201
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```

### POST /api/v1/sessions

Returns user's API key if email/password is valid. Parameters should be sent as a JSON payload in the body of the request for this response.

#### Sample Request

```
POST /api/v1/sessions
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password"
}
```

#### Sample Response

```
status: 200
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```

### POST /api/v1/road_trip

Returns travel time and weather at destination for queried trip. Parameters should be sent as a JSON payload in the body of the request for this response.

#### Sample Request

```
POST /api/v1/road_trip
Content-Type: application/json
Accept: application/json

body:

{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```

#### Sample Response

```{
  "data": {
    "id": null,
    "type": "roadtrip",
    "attributes": {
      "start_city": "Denver, CO",
      "end_city": "Estes Park, CO",
      "travel_time": "2 hours, 13 minutes"
      "weather_at_eta": {
        "temperature": 59.4,
        "conditions": "partly cloudy with a chance of meatballs"
      }
    }
  }
}
```

## Schema

 <p align="center">
 <img src="https://i.imgur.com/OW5QQGw.png">
  </p>


## Dependencies

 * figaro
 * faraday
 * fast_jsonapi
 * shoulda-matchers
 * simplecov

## Testing

* For testing our team implemented Travis CI with RSpec

> Travis CI is cloud based and when we submit a pull request, Travis will attempt to build our project and run the tests to ensure everything is working as expected.

> RSpec is a tool for unit testing that will ensure we have the intended functionality at each level of our code.

* In order to run the tests, run `bundle exec rspec` in the command line and you should have all passing tests.

## Learning Goals

  * Consume two external APIs

  * Build API's that return JSON responses

  * Refactor code for better code for improved organization/readability

  * Practice project management with project boards/daily standups/group retros

  * Utilize workflow: small commits, descriptive pull requests and code review

  * Write thorough and understandable documentation

  * Utilize a Service-Oriented Architecture with a front-end, a back-end, and at least one micro-service

## Licenses

  * Ruby 2.5.3
  * Rails 2.5.4.3

## Contact

#### Nick King: [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/nick-king-3128501ba/), [Email](mailto:nickmaxking@gmail.com), [GitHub](https://github.com/nmking22)

## Acknowledgments

Thank you to Ian Douglas and Dione Wilson for being such amazing instructors and guiding us through this project!

<!-- MARKDOWN LINKS -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
