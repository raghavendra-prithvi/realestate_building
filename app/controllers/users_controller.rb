class UsersController < ApplicationController

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
    @ud.save
    redirect_to "/profile"
  end

      def add
		current_user.itempairs.create( :item_id => params[:item_id], :number => params[:number], :itemname => params[:itemname], :pic => params[:pic], :itemcost => params[:itemcost] )
		redirect_to items_path
	end
end
