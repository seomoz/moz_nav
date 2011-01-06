require 'sinatra/base'
require 'erb'

class User < Struct.new(:account_type)
  def pro?
    account_type == :pro
  end
end

class ExampleApp < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/views'
  set :raise_errors, true
  set :show_exceptions, false

  helpers MozNav::RenderHelpers

  helpers do
    def current_user
      @current_user
    end
  end

  get '/logged_out' do
    erb :index
  end

  get '/free_logged_in' do
    @current_user = User.new(:free)
    erb :index
  end

  get '/pro_logged_in' do
    @current_user = User.new(:pro)
    erb :index
  end
end

