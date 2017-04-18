require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    require 'open-uri'
    @url1="http://maps.googleapis.com/maps/api/geocode/json?address="+@street_address

    parsed_data = JSON.parse(open(@url1).read)
    @lat = parsed_data["results"][0]["geometry"]["location"]["lat"]
    @lng = parsed_data["results"][0]["geometry"]["location"]["lng"]

    @url2="https://api.darksky.net/forecast/6211586540cf1cda8f9a0dc4dc50db9b/"+@lat.to_s+","+@lng.to_s

    parsed_data = JSON.parse(open(@url2).read)
    @current_temperature = parsed_data["currently"]["temperature"]
    @current_summary = parsed_data["minutely"]["summary"]
    @hourly_summary = parsed_data["hourly"]["summary"]
    @next_hour = parsed_data["hourly"]["data"][0]["summary"]
    @next_days = parsed_data["daily"]["summary"]

    @current_temperature = @current_temperature

    @current_summary = @current_summary

    @summary_of_next_sixty_minutes = @hourly_summary

    @summary_of_next_several_hours = @next_hour

    @summary_of_next_several_days = @next_days

    render("meteorologist/street_to_weather.html.erb")
  end
end
