require 'sinatra/base'
require 'erb'
require 'moz_nav'

MozNav.ensure_assets_symlinked_from(File.expand_path('../public', __FILE__))

# This would be a struct but Mustache doesn't play nicely with nested structs
class User
  def initialize(id, account_type)
    @id, @account_type = id, account_type
  end

  attr_reader :id

  def pro?
    @account_type == :pro
  end

  def pm_unread_count
    rand(10)
  end

  def display_name
    "John Doe"
  end
end

class Campaign
  attr_reader :name, :domain_host, :id
  def initialize(id, name = nil, domain_host = nil)
    @id = id
    @name = name || "Campaign #{@id}"
    @domain_host = domain_host || "www.domain-#{@id}.com"
  end

  class << self
    def create!(*args)
      new(*args).tap do |r|
        records << r
        record_hash[r.id] = r
      end
    end

    def find(id)
      record_hash[id.to_i]
    end

    def records
      @records ||= []
    end
    alias all records

    def record_hash
      @record_hass ||= {}
    end
  end

  create! 1, "Apple", "apple.com"
  create! 2, "Microsoft", "microsoft.com"
  create! 3, "SEO Moz", "www.seomoz.org"
end

class ExampleApp < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/views'
  set :raise_errors, true
  set :show_exceptions, false
  set :public, File.dirname(__FILE__) + '/public'

  helpers MozNav::RenderHelper

  helpers do
    def current_user
      @current_user
    end

    def current_campaign
      @current_campaign
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

  get '/campaigns/:id' do
    @current_user = User.new(23, :pro)
    @current_campaign = Campaign.find(params[:id])
    erb :index
  end
end

