require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    require 'open-uri'

    @url="https://api.darksky.net/forecast/6211586540cf1cda8f9a0dc4dc50db9b/"+@lat+","+@lng

    parsed_data = JSON.parse(open(@url).read)
    @current_temperature = parsed_data["currently"]["temperature"]
    @current_summary = parsed_data["minutely"]["summary"]
    @hourly_summary = parsed_data["hourly"]["summary"]
    @next_hour = parsed_data["hourly"]["data"][0]["summary"]
    @next_days = parsed_data["daily"]["summary"]

    @current_temperature = @current_temperature

    @current_summary = @current_summary

    @summary_of_next_sixty_minutes = @next_hour

    @summary_of_next_several_hours = @hourly_summary

    @summary_of_next_several_days = @next_days

    render("forecast/coords_to_weather.html.erb")
  end
end
