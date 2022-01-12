class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    @micropost  = current_user.microposts.build
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def current_user?(user)
    user == current_user
  end

  def create
    @user = User.new(user_params)
    @user.avatar.attach(params[:user][:avatar])
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "Welcome to CryptoDeck!"
      redirect_to edit_user_path(current_user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Portal Updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User Portal Has Been Deleted"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:avatar, :banner, :first_name, :middle_name, :last_name, :username, :bio, :phone, :email, :location, :job_title, :job_duties, :company_name, :college_name, :college_degree, :btc_adr, :eth_adr, :password, :password_confirmation)
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please Enter Your Portal First!"
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
