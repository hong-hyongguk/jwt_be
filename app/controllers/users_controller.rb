class UsersController < ApplicationController
  before_action :authorize_request, except: :create

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def show
    puts "current_user: #{@current_user}"
    render json: @current_user, status: :ok
  end

  # PUT /users/{username}
  def update
    unless @current_user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /users/{username}
  def destroy
    @current_user.destroy
  end

  private

  def user_params
    params.permit(
      :email, :password, :password_confirmation, :role
    )
  end
end
