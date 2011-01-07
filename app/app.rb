require 'sinatra/base'
require 'erb'
require 'moz_nav'

class User < Struct.new(:id, :account_type)
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

  get '/' do
    erb :index
  end

  get '/logged_out' do
    erb :index
  end

  get '/free_logged_in/:id' do
    @current_user = User.new(params[:id], :free)
    erb :index
  end

  get '/pro_logged_in/:id' do
    @current_user = User.new(params[:id], :pro)
    erb :index
  end
end

