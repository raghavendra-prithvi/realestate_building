class ListingsController < ApplicationController
  # GET /listingssession
  # GET /listings.json
  before_filter :require_login, :except => ['show','home_search','my_search_listing','get_contact','show_image']
  def index
    @user = User.find(session[:user_id])
    puts @user.inspect
    @listings = @user.listings.all(:order => 'created_at DESC')
    puts @listings
    #@listings = Listing.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json => @listings }
    end
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @ajxRqst = false
    if(!request.xhr?)
      @ajxRqst = true
    end
    @listing = Listing.find(params[:id])
    puts @listing.inspect

    @favourite = false
    if(!session[:user_id].nil?)
      @user = User.find(session[:user_id])
      if @listing.voted_on_by?(@user)
        @favourite = true
      end
    end
    @pictures = @listing.pictures

    render :html => "show", :layout => @ajxRqst

#    respond_to do |format|
#      #format.html { :layout => false }# show.html.erb
#
#      format.json { render json: @listing }
#    end
  end

  # GET /listings/new
  # GET /listings/new.json
  def new
    @listing = Listing.new

    respond_to do |format|
      format.html  # new.html.erb
      format.json { render json => @listing }
    end
  end

  # GET /listings/1/edit
  def edit
    @listing = Listing.find(params[:id])
  end

  # POST /listings
  # POST /listings.json
  def create
    puts params[:listing]
    params[:listing][:tap_description] = params[:listing][:description].to_s + "-"+params[:listing][:bedrooms].to_s + "Beds-"+ params[:listing][:bathrooms].to_s + "Baths -" + params[:listing][:squarefootage].to_s + "sq.ft"
    @listing = Listing.new(params[:listing])
    @listing.user_id = current_user.id
    if !params[:image_file].nil?
      @uploadimages = Picture.new
      @uploadimages.upload_file_name = params[:image_file].original_filename
      @uploadimages.upload_content_type = params[:image_file].content_type
      @uploadimages.upload_file_size = params[:image_file].size
      @uploadimages.data = params[:image_file].read
    end
    respond_to do |format|
      if @listing.save
        @listings = Listing.where(:user_id => current_user.id)
        if !params[:image_file].nil?
          @uploadimages.listing_id = @listing.id
          @uploadimages.save
        end
        format.html { redirect_to '/mylistings', notice: 'Listing was successfully created.' }
        format.json { render json: @listings, status: :created, location: @listing }
      else
        format.html { render action: "new" }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /listings/1
  # PUT /listings/1.json
  def update
    @listing = Listing.find(params[:id])
    puts "lat long"
    puts @listing.lat
    puts @listing.long

    respond_to do |format|
      if @listing.update_attributes(params[:listing])
        format.html { redirect_to '/mylistings', notice: 'Listing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy

    respond_to do |format|
      format.html { redirect_to listings_url }
      format.json { head :no_content }
    end
  end


  def home_search
    puts params.inspect
    @recent_listings = Listing.find(:all, :order => "id desc", :limit => 5)
    if(!session[:user_id].nil?)
      @user = User.find(session[:user_id])
      @favs = @user.votes.up.collect { |obj| obj.votable_id }
      @favourite_listings = Listing.find(@favs)
      @searches = @user.searches
      @my_saved_listings = []
      @searches.each do |srch|
        query = []
        query << "listing_type = '#{srch.buy_rent}'" if srch.buy_rent.present?
        query << "price >= #{srch.min_amount}" if srch.min_amount.present?
        query << "price <= #{srch.max_amount}" if srch.max_amount.present?
        query << "bedrooms = #{srch.beds}" if srch.beds.present?
        query << "bathrooms = #{srch.bath}" if srch.bath.present?
        query << "zip = #{srch.zip}" if srch.zip.present?
        #query << "status = true"
        puts srch.days_before.to_s + "days"
        if srch.days_before == "active"
          query << "status = true"
        else
          query << "created_at >= '#{srch.days_before.to_i.days.ago}'"
        end
        puts "Query:" + query.join("AND").to_s
         
           lists1 = Listing.where(query.join(" AND "))
           @my_saved_listings = @my_saved_listings + lists1
           puts @my_saved_listings.inspect
      end
      @my_saved_listings = @my_saved_listings.uniq
    end


    @listings = Listing.where(:listing_type => params[:buy_rent], :status => true)
    puts "*********************"
    puts @listings.inspect
    @listings = @listings.where("price <= ?",params[:amount].to_i) if params[:amount].present?
    puts "****************23*****"
    puts @listings.inspect
  end

  def my_search_listing
    @key_search_listings = Listing.search(params[:key_search]) if params[:key_search].present?
    query = []
    query << "listing_type = '#{params[:buy_rent]}'" if params[:buy_rent].present?
    query << "price >= #{params[:min_amount]}" if params[:min_amount].present?
    query << "price <= #{params[:max_amount]}" if params[:max_amount].present?
    query << "bedrooms = #{params[:bedrooms]}" if params[:bedrooms].present?
    query << "bathrooms = #{params[:bathrooms]}" if params[:bathrooms].present?
    query << "zip = #{params[:zip]}" if params[:zip].present?
    #query << "status = true"
    if params[:days_before] == "active"
      query << "status = true"
    else
      query << "created_at >= '#{params[:days_before].to_i.days.ago}'"
    end

    @listings = Listing.where(query.join(" AND "))
    if params[:key_search].present?       
        @listings  = @listings & @key_search_listings       
    end
    render :layout => false
  end


  def get_contact
    @user = Listing.find(params[:listing_id].to_i).user

    @ud =   UserDetail.find_by_uid(@user.uid)

    render :html => "get_contact", :layout => false
  end

  def show_image
      @image = Picture.find(params[:id])
      send_data @image.data, :type => 'image/png', :disposition => 'inline'
  end

  def add_images

      @pictures = Listing.where(:id => params[:listing_id]).first.pictures
     render :html => "add_images", :layout => false
  end

  def upload_image
    uploadimages = Picture.new
    uploadimages.upload_file_name = params[:image_file].original_filename
    uploadimages.upload_content_type = params[:image_file].content_type
    uploadimages.upload_file_size = params[:image_file].size
    uploadimages.data = params[:image_file].read
    uploadimages.listing_id = params[:listing_id]
    uploadimages.save!
    render :text => uploadimages.id
    #puts "saved"
  end

  def rename
    @listing = Listing.find(params[:id])
    @listing.update_attribute('name', params["listing-name"])
    redirect_to mylistings_path
  end

  def vote_up
    @user = User.find(session[:user_id])
    @listing = Listing.find(params[:lid])
    @listing.liked_by @user
    render :text => "Favourite Added"
  end

  def vote_remove
    @user = User.find(session[:user_id])
    @listing = Listing.find(params[:lid])
    @listing.unvote :voter => @user
    render :text => "Favourite Removed."
  end

  def vote_down
    @user = User.find(session[:user_id])
    @listing = Listing.find(params[:lid])
    @listing.downvote_from @user
    render :text => "disliked"
  end

end
