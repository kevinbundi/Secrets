class LikesController < ApplicationController
  before_action :require_login
  
  def create
  	like = Like.create(secret: Secret.find(params[:id]), user: current_user)
  	like.save
  	redirect_to secrets_path
  end
  def destroy
  	likes = Like.where(user: current_user, secret: Secret.find(params[:id]))
    likes.each{ |like| like.destroy } 
  	redirect_to secrets_path 
  end
end

