class UsersController < SistemaController

  before_action :set_user, only: [:edit, :show, :update]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_url, notice: "User was successfully updated." 
    else
       render :new, notice: ":unprocessable_entity "
    end
  end
  
  
  def show 
  end

  def edit
  end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].extract!(:password, :password_confirmation)
    end
    if @user.update(user_params)
     redirect_to users_url, notice: "User was successfully updated." 
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :super_admin)
  end

end
