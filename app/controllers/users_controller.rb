class UsersController < ApplicationController
  before_action :require_login, except:[:create, :new]
  before_action :logged_in, only: [:new]

  def index
  end

  def create
  	user = User.create(register_params)
  	if user.valid? == true 
  		user.save
  		flash[:message] = "registration successful"
  		redirect_to '/sessions/new'
  	else
  		flash[:reg_errors] = [] 
      user.errors.full_messages.each do |msg|
          flash[:reg_errors] << msg
      end
  		redirect_to '/users/new' 
  	end
  end
  def new
  end

  def show
  	@user = User.find(session[:user_id])
    @secrets = Secret.where(user: current_user).reverse
    @secrets_liked = current_user.secrets_liked.reverse
  end

  def edit
  	@user = User.find(session[:user_id])
  end

  def update
  	user = User.update params[:id], update_params
  	if user.save
  		flash[:update_message] = "update successful"
  		redirect_to '/users/' + user.id.to_s
  	else
  		flash[:update_error] = user.errors.full_messages
  		redirect_to '/users/' + params[:id].to_s + '/edit/'
  	end
  end

  def destroy
  	user = User.find params[:id]
  	user.destroy
  	session[:user_id] = nil
  	flash[:message] = "account deleted"
  	redirect_to '/users/new' 
  end

  private
  def register_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  def update_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
