require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'active_record'

require_relative 'db_config'
require_relative 'domain_api'
require_relative 'models/user'

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

end

get '/' do
    if logged_in?
        erb :index
    else
        redirect 'login'
    end


    # @data = DomainAPI.get_access_token()
    # @listing = DomainAPI.get_property_by_Id("RF-8884-AK", @data["access_token"])
    # @properties = DomainAPI.get_properties_by_terms("lydia street" ,@data["access_token"])
end

get '/login' do
    erb :login
end

post '/login' do
    
    
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
    redirect :login
end
