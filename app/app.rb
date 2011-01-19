require 'sinatra/base'
require 'erb'
require 'moz_nav'

# This would be a struct but Mustache doesn't play nicely with nested structs
class User
  def initialize(id, account_type)
    @id, @account_type = id, account_type
  end

  attr_reader :id

  def pro?
    @account_type == :pro
  end

  def display_name
    "John Doe"
  end
end

class ExampleApp < Sinatra::Base
  CAMPAIGNS = [
    ['Apple Computer', 'http://apple.com'],
    ['Microsoft',      'http://microsoft.com'],
    ['SEO Moz',        'http://www.seomoz.org']
  ]

  set :views, File.dirname(__FILE__) + '/views'
  set :raise_errors, true
  set :show_exceptions, false
  set :public, File.dirname(__FILE__) + '/public'

  helpers MozNav::RenderHelper

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

