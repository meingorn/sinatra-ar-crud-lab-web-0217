require_relative '../../config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/posts' do
    erb :index
  end

  post '/posts' do
    Post.create(name: params[:name], content: params[:content])
    erb :index
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts/new' do
    Post.create(name: params[:name], content: params[:content])
    erb :index
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :show
  end

  post '/posts/:id' do
    @post = Post.find(params[:id])
    @post.name = params[:name]
    @post.content = params[:content]
    @post.save
    # binding.pry
    redirect to "/posts/#{@post.id}"
  end

  get '/posts/:id/edit' do
    @post = Post.find_by_id(params[:id])
    # binding.pry
    erb :edit
  end

  post '/posts/:id/edit' do
    @post = Post.find(params[:id])
    @post.name = params[:name]
    @post.content = params[:content]
    @post.save
    # binding.pry
    redirect to "/posts/#{@post.id}"
  end

  post '/posts/:id/delete' do
    post = Post.find(params[:id])
    name = post.name
    str = "#{name} was deleted"
    post.destroy
    str
  end

end
