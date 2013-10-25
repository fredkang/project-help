class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  #Create a new user. This will only include basic information - it does not include Description or Help Offers
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        @group_user = Groupuser.new(user_id: @user.id, group_id: 1).save
        sign_in(@user)
        format.html { redirect_to '/users/'+@user.id.to_s+"/new2" } #@user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  #Part 2 of new member registration. This page will include a form to fill out the user's Description and add
  #Help Offers
  def new2
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])

    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def show
    @topics = @user.helpoffers
  end

  def index
    if !signed_in?
      deny_access
    end
    
    @users = User.all
  end

  def edit
  end

  def update
    @user = User.find(params[:id])

    params[:user].delete(:password) if params[:user][:password].blank?

    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to :back } #@user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new2' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

  # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone_number, :password, :password_confirmation, :description, helpoffers_attributes: [:user_id, :id, :title, :description, '_destroy'])
    end
end
