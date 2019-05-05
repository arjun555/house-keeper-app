require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'active_record'

require_relative 'db_config'
require_relative 'domain_api'
require_relative 'models/user'
require_relative 'models/property'
require_relative 'models/user'
require_relative 'models/comment'

enable :sessions

# after - means after every route/request
after do
    ActiveRecord::Base.connection.close
end

helpers do

    def current_user
      User.find_by(id: session[:user_id])
    end
  
    def logged_in?
      # !!current_user() - also converts the value to a boolean. Double negation is used when nil values are possible
      if current_user()
        return true
      else
        return false
      end
    end

    def user_properties
        Property.where(agent_id: session[:user_id])
    end

end

get '/' do
    if logged_in?
        # @api_data = DomainAPI.get_access_token()
        if current_user.account_type == "agent"
            redirect '/home/agent'
        elsif current_user.account_type == "tenant"
            redirect '/home/tenant'
        else
        end
    else
        redirect '/login'
    end

    # @listing = DomainAPI.get_property_by_Id("RF-8884-AK", @data["access_token"])
    # @properties = DomainAPI.get_properties_by_terms("lydia street" ,@data["access_token"])
end

get '/home/agent' do
    erb :agent_dashboard
end

get '/home/tenant' do
    erb :tenant_dashboard
end

get '/search' do
    erb :search
end


get '/search/property' do
    puts params[:query]
    @api_data = DomainAPI.get_access_token()
    @properties = DomainAPI.get_properties_by_terms(params[:query],@api_data["access_token"])
    erb :search
end

get '/property' do
    params[:id]
    @api_data = DomainAPI.get_access_token()
    @property = DomainAPI.get_property_by_Id(params[:id],@api_data["access_token"])
    @comments = Comment.where(domain_id: params[:id])
    erb :property
end

post '/property' do
    property = Property.new
    property.domain_id = params[:id]
    property.agent_id = current_user.id
    property.save
    redirect "/property?id=#{property.domain_id}"
end

get '/agent/properties' do
    @properties = []
    properties = Property.where(agent_id: session[:user_id])
    properties.each do |property|
        @api_data = DomainAPI.get_access_token()
        @property = DomainAPI.get_property_by_Id(property["domain_id"],@api_data["access_token"])
        @properties.push(@property)
    end
    erb :agent_properties
end

post '/comments' do
    comment = Comment.new
    comment.content = params[:content]
    comment.domain_id = params[:domain_id]
    comment.user_id = current_user.id
    comment.save
    redirect "/property?id=#{comment.domain_id}"
end

get '/login' do
    @user = User.new
    erb :login
end

post '/login' do
    @user = User.new
    @user.email = params[:email]
    @user.account_type = params[:account_type]
    if User.exists?(email: params[:email])
        @login_status = "Account already exists"
        erb :login
    else
        # @login_status = "Account already exists"
        erb :create_account
    end
end

post '/create_account' do
    if(params[:password] == params[:password_verify])
        user = User.new
        user.email = params[:email]
        user.password = params[:password]
        user.account_type = params[:account_type]
        user.save
        redirect '/'
    else
        @user = User.new
        @user.email = params[:email]
        @login_status = "Password Mismatch"
        erb :create_account
    end

end

post '/session' do
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
        # user exists and is authenticated
        session[:user_id] = user.id
        redirect '/'
    end
end
  
delete '/session' do
    session[:user_id] = nil
    redirect '/'
end
