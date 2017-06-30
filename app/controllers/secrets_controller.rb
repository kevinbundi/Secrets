class SecretsController < ApplicationController
  before_action :require_login
  
  def index
  	@secrets = Secret.all.reverse
  	@secrets_liked = current_user.secrets_liked
  end
  def create
  	secret = Secret.create(content: params[:content], user: current_user)
  	if secret.valid? == true
  		secret.save
  		redirect_to '/users/' + current_user.id.to_s
  	else
  		flash[:secret_errors] = secret.errors.full_messages 
  		redirect_to '/users/' + current_user.id.to_s
  	end
  end
  def edit
    @secret = Secret.find(params[:id])
  end
  def update
    secret = Secret.update params[:id], content: params[:content] 
    if secret.save
      redirect_to '/users/' + current_user.id.to_s
    else
      flash[:secret_update_error] = secret.errors.full_messages
      redirect_to 'secrets' + params[:id].to_s + '/edit'
    end
  end
  def destroy
  	Secret.find(params[:id]).destroy
  	redirect_to secrets_path
  end
  def destroy_user_secrets
  	Secret.find(params[:id]).destroy
  	redirect_to '/users/' + current_user.id.to_s
  end
end
