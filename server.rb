require 'sinatra'
require 'json'

configure do
  $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
  Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb") { |lib| 
    require File.basename(lib, '.*') 
  }
  Location.init
end

get '/' do
  "<html><body><h1>Hi! 👋 <br/>I suggest you try #{Location.suggest[:name]}</h1></body></html>"
end

get '/locations/suggest' do
  Location.suggest.to_json
end

get '/locations/tried' do
  Location.tried.to_json
end

get '/locations/not-tried' do
  Location.not_tried.to_json
end


get '/locations' do
  # default: all
  result = Location.all

  # if params[:filter]
  # 	if params[:filter].downcase=="tried"
  #     result = Location.tried
  #   elsif params[:filter].downcase=="not-tried"
  #     result = Location.not_tried
  #   end
  # end
  
  result.to_json
end