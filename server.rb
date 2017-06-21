require 'sinatra'
require 'sinatra/json'
require 'sinatra/cross_origin'
require 'json'

configure do
  enable :cross_origin
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
  json Location.suggest
end

get '/locations/tried' do
  json Location.tried
end

get '/locations/not-tried' do
  json Location.not_tried
end

get '/locations' do
  json Location.all
end