class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,     only: [:edit, :update]

  def new
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
  end
  def edit
  end
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Successfully updated..."
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Successfully created..."
      redirect_to @user
    else
      render 'show'
    end
  end
  def index
    @users = User.paginate(page: params[:page])
  end

def destroy
  User.find(params[:id]).destroy
  flash[:success] = "User deleted"
  redirect_to users_url
end
  private

      def signed_in_user
        unless signed_in?
          store_location
          redirect_to signin_url, notice: "Please sign in"
        end
      end

      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user)
      end
end
