require 'pg'
require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'house_keepers'
}

ActiveRecord::Base.establish_connection(options)