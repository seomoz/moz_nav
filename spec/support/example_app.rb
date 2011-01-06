require 'sinatra/base'
require 'erb'

class ExampleApp < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/views'

  helpers MozNav::RenderHelpers

  get '/' do
    erb :index
  end
end

