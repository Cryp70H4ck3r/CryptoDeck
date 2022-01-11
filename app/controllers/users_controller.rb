class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to CryptoDeck!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :middle_name, :last_name, :username, :bio, :phone, :email, :location, :job_title, :job_duties, :company_name, :college_name, :college_degree, :btc_adr, :eth_adr, :password, :password_confirmation)
    end

end
