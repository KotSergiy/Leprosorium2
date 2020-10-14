#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "leprosorium2.db"}

class Post < ActiveRecord::Base
	validates :author, presence: true
	validates :content, presence: true, length: {minimum: 5}
end

class Comment < ActiveRecord::Base
end

get '/' do
	erb :main
end

get '/new' do
  erb :new
end

post '/new' do
	@new_post=Post.new params[:post]
	if @new_post.save
		erb "<h2>Спасибо, вы записались!</h2>"
	else
		@error=@new_post.errors.full_messages.first
		erb :new
	end
end
