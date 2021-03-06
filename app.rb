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
	validates :content, presence: true, length: {minimum: 5}
end

get '/' do
	@posts=Post.order 'created_at DESC'
	erb :main
end

get '/new' do
	@new_post=Post.new
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

get '/details/:id' do
  @post=Post.find params[:id]
	@comments=Comment.where("post_id=?", params[:id]).order 'created_at DESC'
	erb :details
end

post '/details/:id' do
	@post=Post.find params[:id]

	@new_comment=Comment.new(content: params[:content], post_id: params[:id])
	if !(@new_comment.save)
		@error=@new_comment.errors.full_messages.first
	end

	@comments=Comment.where("post_id=?", params[:id]).order 'created_at DESC'

	erb :details
end
