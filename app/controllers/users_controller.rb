class UsersController < ApplicationController
	before_filter :require_login, :only => ['messages','reply_message','send_message','delete_message']
  def new
  	@user = User.new
  	if current_user.present?
  		redirect_to petitions_path
  	end
  end

  def destroy
    sign_out
    redirect_to petitions_path
  end


  def remove
  	@votedfor = current_user.vote
  	@vote1 = @votedfor.vote1
  	@vote2 = @votedfor.vote2
  	@vote3 = @votedfor.vote3
  	@petitionnum = params[:order_param]
  	@petition = Petition.find(params[:order_param])
  	@rating = @petition.rating
  end


  def create
    @user = User.new(params[:user])

    if @user.save
      @ud = UserDetail.new
      @ud.uid = @user.id
      @ud.email = @user.email
      @ud.save
      flash[:success] = "Thanks for Registering! An e-mail has been sent to you to confirm your account"
      redirect_to petitions_path
	  UserMailer.registration_confirmation(@user).deliver
    else
      render 'new'
    end
  end


  def edit
  	@user = User.find(params[:id])
	@status = @user.confirmed
	
		if @status == "false"
			session[:user_id] = @user.id
			confirm @user
			flash[:success] = "Successfully logged in!"
			redirect_to petitions_path
		end
  end


  def update
	if current_user.update_attributes(params[:user])
		flash[:success] = "Modified Account!"
		redirect_to petitions_path
	else
		flash[:success] = "NOT Modified Account!"
		redirect_to petitions_path
	end
  end

  def registered
	@user = current_user
  end

  def profile
    @user = User.find(session[:user_id])
    session[:uid] = @user.uid
    @ud =   UserDetail.find_by_uid(@user.uid)
    if @ud.blank?
      @ud = UserDetail.new
      @ud.email = @user.email
      @ud.uid = @user.uid
      @ud.save
    end
  end

  def edit_profile
        @ud =   UserDetail.find_by_uid(session[:uid])
        @ud.save
  end

  def save_profile
    @ud = UserDetail.find_by_uid(session[:uid])
    @ud.first_name = params[:first_name]
    @ud.last_name = params[:last_name]
    @ud.address1 = params[:address1]
    @ud.address2 = params[:address2]
    @ud.email = params[:email]
    @ud.city = params[:city]
    @ud.zip = params[:zip]
    @ud.profile_public = params[:profile_public]
    @ud.phone = params[:phone]
	if !params[:image_file].nil?
      @uploadimages = Picture.new
      @uploadimages.upload_file_name = params[:image_file].original_filename
      @uploadimages.upload_content_type = params[:image_file].content_type
      @uploadimages.upload_file_size = params[:image_file].size
      @uploadimages.data = params[:image_file].read
	  @uploadimages.save
	  @ud.picture_id = @uploadimages.id
    end
	
    @ud.save
    redirect_to "/profile"
  end

  def add
		current_user.itempairs.create( :item_id => params[:item_id], :number => params[:number], :itemname => params[:itemname], :pic => params[:pic], :itemcost => params[:itemcost] )
		redirect_to items_path
	end

  def messages
    @user = User.find(session[:user_id])
    @message_count = @user.unread_message_count
    @messages = @user.received_messages
    @sent_messages = @user.sent_messages
  end

  def reply_message
    puts params.inspect
    @old_msg = Message.find(params[:mesg_id])
    @new_msg = Message.new()
    @new_msg.subject = params[:subject]
    @new_msg.body = params[:body]
    @new_msg.sender = @old_msg.recipient
    @new_msg.recipient = @old_msg.sender
    @new_msg.save
    redirect_to :action => 'messages'
  end

 def send_message
   puts params.inspect
   @lstng_owner = User.find(params[:listing_owner])
   @current_user = User.find(session[:user_id])
    @new_msg = Message.new()
    @new_msg.subject = params[:subject]
    @new_msg.listing_id = params[:listing_id]
   @new_msg.body = params[:body]
    @new_msg.sender = @current_user
    @new_msg.recipient = @lstng_owner
    @new_msg.save
    render :text => 'successfully sent the message'
 end

 def delete_message
   @user = User.find(session[:user_id])
   message = Message.find(params[:id])
   message.mark_deleted(@user)
   render :text => 'deleted successfully'
 end
end
