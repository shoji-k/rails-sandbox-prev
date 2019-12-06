class Api::V1::UsersController < Api::V1::ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    users = User.all
    render json: UserSerializer.new(users).serialized_json
  end

  # GET /users/1
  def show
    render json: UserSerializer.new(@user).serialized_json
  end

  # POST /users
  def create
    user = User.new(user_params)

    if user.save
      render json: UserSerializer.new(user).serialized_json, status: :created,
             location: api_v1_user_path(user)
    else
      render_error(user)
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(User.column_names, :password, :password_confirmation)
  end
end
