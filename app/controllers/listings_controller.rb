class ListingsController < ApplicationController
  # GET /listings
  # GET /listings.json
  def index
    @user = User.find(session[:user_id])
    @listings = @user.listings
    #@listings = Listing.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @listings }
    end
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @listing = Listing.find(params[:id])

    render :html => "show", :layout => false

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
      format.json { render json: @listing }
    end
  end

  # GET /listings/1/edit
  def edit
    @listing = Listing.find(params[:id])
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(params[:listing])
    @listings = Listing.all

    respond_to do |format|
      if @listing.save
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
    @listings = Listing.where(:listing_type => params[:buy_rent]).where("price <= ?",params[:amount])
    puts "*********************"
    puts @listings.inspect
  end

  def my_search_listing
    puts "****************"
    puts params.inspect
    @search = Listing.search do
       params[:search]
    end
    @lists_key = @search.results

    @listings = Listing.where(:listing_type => params[:buy_rent]).where("price <= ?",params[:max_amount]).where("price >=",params[:min_amount])
    render :text => @lists_key.to_s
  end
end
