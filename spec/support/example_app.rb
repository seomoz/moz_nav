require 'sinatra/base'
require 'erb'

class ExampleApp < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/views'
  set :raise_errors, true
  set :show_exceptions, false

  helpers MozNav::RenderHelpers

  get '/' do
    erb :index
  end
end

