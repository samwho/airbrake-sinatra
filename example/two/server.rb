require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'airbrake-sinatra')

require 'sinatra'
require 'sinatra/airbrake-javascript'
require 'erb'
require 'haml'
require 'airbrake'

class Server < Sinatra::Base
  helpers do
    include Rack::Utils
    include Sinatra::AirbrakeJavascript
    alias_method :h, :escape_html
  end

  configure do
    set :logging, Logger::DEBUG

    Airbrake.configure do |config|
      config.api_key    = 'sample'
      config.js_api_key = 'sample'
      config.host       = 'example.com'
      config.port       = 80
      config.secure     = config.port == 443
    end

    use Airbrake::Rack
    enable :raise_errors
  end

  get '/erb' do
    erb :erb_index
  end

  get '/haml' do
    haml :haml_index
  end
end
