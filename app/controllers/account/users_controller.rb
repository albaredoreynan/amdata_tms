class Account::UsersController < ApplicationController
	before_filter :set_user, only: [:show, :update, :destroy, :edit] 

  def index
    # if current_user.role.access_level == 'Administrator' || current_user.role.access_level == 'All'
    #   # @users = current_user.department.nil? ? User.all : User.where(department: current_user.department)
    #   # render json: @users
    #   split_space(params["q"]) if params["q"].present?
    #   @q = User.ransack(params[:q])
    #   @users = @q.result.order("created_at asc").paginate(:page => params[:page], :per_page => 10)
    # else
    #   # redirect_to _logreqs_path
    #   redirect_to dashboard_path
    # end
    @users = User.all
  end

  def split_space(contents)
    contents.values.each { |c| c.strip! if c.present? }
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # render json: @user, status: :created, user: [:api, @user]
      redirect_to account_users_path, notice: 'Entry created'
    else
      redirect_to new_account_user_path, alert: @user.errors.full_messages.first
      # render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def update
    # if @user.update(user_params)
    #   if user_params[:tag] == 'false'
    #     redirect_to request.referer
    #   else
    #     redirect_to account_users_path, notice: 'Entry updated'
    #   end
    # else
    #   redirect_to edit_account_user_path, alert: @user.errors.full_messages.first
    # end
    if @user.update(user_params)
      redirect_to account_users_path, notice: 'Entry updated'
    else
      flash[:alert] = @user.errors.full_messages.first
      render action: "new", id: @user.id
      # redirect_to edit_client_path, alert: @client.errors.full_messages.to_sentence
      # render json: { errors: @client.errors }, status: :unprocessable_entity
    end
  end
  
  def show
    render json: @user
  end

  def destroy
    @user.destroy
    redirect_to account_users_path, notice: 'Entry successfully deleted'
    # head :no_content
  end

  def new
    @user = User.new
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def set_account_user_from_token
      @user = User.find(params[:id])
    end
      
    def user_params
      # split_space(params[:user])
      params.require(:user).permit(:email, :first_name, :last_name, :middle_name, :password, 
                                   :password_confirmation, :home_address, :contact_number, 
                                   :rate_per_hour, :role_type, :job_title, :username)
    end
end