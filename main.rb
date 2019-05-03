require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'active_record'

require_relative 'domain_api'

get '/' do
    @data = DomainAPI.get_access_token()
    # @listing = DomainAPI.get_property_by_Id("RF-8884-AK", @data["access_token"])
    # @properties = DomainAPI.get_properties_by_terms("lydia street" ,@data["access_token"])
    erb :index
end


