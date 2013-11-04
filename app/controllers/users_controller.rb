class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user?, only: [:edit, :update, :destroy]
  before_action :deny_access, only: [:admin_panel, :new2, :destroy, :show, :index, :edit, :update]

  def new
    if signed_in?
      redirect_to '/users'
    end

    @user = User.new
  end

  #Create a new user. This will only include basic information - it does not include Description or Help Offers
  def create

    group_id = Group.check_code(params['access_code'])
    puts "access code is: " + params['access_code']

    if(group_id == false)
      redirect_to '/users/new', notice: 'Invalid Group Code'
    else

      if User.all.count == 0
        params['user']['admin'] = 1
      else
        params['user']['admin'] = 0
      end
      
      @user = User.new(user_params)

      respond_to do |format|

        #If the new user is saved without error, automatically create an entry in Groupuser to add this user to Group 1.
        #Then sign in the user
        if @user.save
          @group_user = Groupuser.new(user_id: @user.id, group_id: group_id, groupowner:0, groupadmin:0).save
          sign_in(@user)
          format.html { redirect_to '/users/'+@user.id.to_s+"/new2" } #@user, notice: 'User was successfully created.' }
          format.json { render action: 'show', status: :created, location: @user }
        else
          format.html { render action: 'new' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end  
  end

  #Controller for admin page. Page that is only viewable to admins. They can see all users, edit users and destroy users
  def admin_panel
    if current_user.admin == 1
      @users = User.all
    else
      redirect_to "/users"
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
      format.html { redirect_to users_admin_url }
      format.json { head :no_content }
    end
  end

  def show
    @topics = @user.helpoffers
    @posts = @user.posts.order("created_at DESC").all
    @newpost = @user.posts.new

    current_user.profilenotes.destroy_all

    @conversation = Conversation.getConvo(current_user.id, @user.id)

    if @conversation.nil?
      @conversation = Conversation.new
    end

    @conversation.messages.build
    
    # TestMailer.test_email.deliver
  end

  def index
    deny_access
    
    # Grab all of the users that are in any of the same groups as the current_user

    # First grab all of the users
    all_users = User.all.to_a.sort_by { |obj| obj.first_name }

    @users = []

    # Go through each user and check if it is any of the same groups as the current user
    all_users.each do |user|
      if (user.groups.to_a & current_user.groups.to_a).length>0
        @users.push(user)
      end
    end

    # Store all of the help topics of these people have listed - all of the topics
    # that are available to this user
    @helptopics = []

    @users.each do |user|
      user.helpoffers.to_a.each do |topic|
        @helptopics.push(topic)
      end
    end

    @helptopics = @helptopics.sort_by { |obj| obj.title}
  end

  def edit
  end

  def update
    @user = User.find(params[:id])

    params[:user].delete(:password) if params[:user][:password].blank?

    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to "/users/"+params[:id].to_s } #@user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'edit' }
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
      params.require(:user).permit(:first_name, :last_name, :email, :phone_number, :password, :password_confirmation, :description, :admin, :image, :remote_image_url, :access_code, helpoffers_attributes: [:user_id, :id, :title, :description, '_destroy'])
    end

    
end
