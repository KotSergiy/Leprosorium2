#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "leprosorium2.db"}

class Post < ActiveRecord::Base
end

class Comment < ActiveRecord::Base
end

get '/' do
	erb :main
end

get '/new' do
  erb :new
end
