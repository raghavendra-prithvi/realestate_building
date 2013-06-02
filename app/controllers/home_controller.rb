class HomeController < ApplicationController
  before_filter :require_login, :except => ['index']
  def index
  end

  def save_search
    puts "************"
    puts params.inspect
    @search = Search.new
    @search.user_id = session[:user_id]
    @search.keywords = params[:key_search]
    @search.min_amount = params[:min_amount]
    @search.max_amount = params[:max_amount]
    @search.bath = params[:bathrooms]
    @search.beds = params[:bedrooms]
    @search.buy_rent = params[:buy_rent]
    @search.zip = params[:zip]
    @search.name = params[:name]
    @search.days_before = params[:days_before]
    if @search.save!
      render :text => "successfully saved Search Criteria"
    end
  end

  def mysearches
    @user = User.find(session[:user_id])
    @searches = @user.searches.reverse
    #@searches.sort!{|a,b|a.updated_at <=> b.updated_at}
  end

  def get_search_details
    @search = Search.find(params[:id])

    @lists_key = []
    if(!@search.keywords.nil? && @search.keywords != '')
      @lists_key = Listing.search(@search.keywords)
    end
    query = []
    query << "listing_type = '#{@search.buy_rent}'" if @search.buy_rent.present?
    query << "price >= #{@search.min_amount}" if @search.min_amount.present?
    query << "price <= #{@search.max_amount}" if @search.max_amount.present?
    query << "bedrooms = #{@search.beds}" if @search.beds.present?
    query << "bathrooms = #{@search.bath}" if @search.bath.present?
    query << "zip = #{@search.zip}" if @search.zip.present?
    #query << "status = true"
    if @search.days_before == "active"  || @search.days_before.to_i == 0
      query << "status = true"
    else
      query << "created_at >= '#{@search.days_before.to_i.days.ago}'"
    end

    puts "*****************************"
    puts "sql query: #{query}"
    @listings = Listing.where(query.join(" AND ")) #where(:listing_type => params[:buy_rent]).where("price <= ?",params[:max_amount]).where("price >=",params[:min_amount])
    puts "******************88"
    puts @listings.inspect
    render :html => "get_search_details", :layout => false
  end

  def search_with_criteria
    puts params.inspect
    @search = Search.find(params[:id])

    @lists_key = []
    if(!@search.keywords.nil? && @search.keywords != '')
      @lists_key = Listing.search(@search.keywords)
    end
    query = []
    query << "listing_type = '#{@search.buy_rent}'" if @search.buy_rent.present?
    query << "price >= #{@search.min_amount}" if @search.min_amount.present?
    query << "price <= #{@search.max_amount}" if @search.max_amount.present?
    query << "bedrooms = #{@search.beds}" if @search.beds.present?
    query << "bathrooms = #{@search.bath}" if @search.bath.present?
    query << "zip = #{@search.zip}" if @search.zip.present?
    #query << "status = true"
    if @search.days_before == "active"  || @search.days_before.to_i == 0
      query << "status = true"
    else
      query << "created_at >= '#{@search.days_before.to_i.days.ago}'"
    end

    puts "*****************************"
    puts "sql query: #{query}"
    @listings = Listing.where(query.join(" AND ")) #where(:listing_type => params[:buy_rent]).where("price <= ?",params[:max_amount]).where("price >=",params[:min_amount])

    puts @listings.inspect
    #    render :text => @lists_key.to_s
    render :html => "search_with_criteria", :layout => false
  end

  def get_favourite_search_details
    @user = User.find(session[:user_id])
    @favs = @user.votes.up.collect { |obj| obj.votable_id }
    @listings = Listing.find(@favs)
    render :html => "get_favourite_search_details", :layout => false
  end

end
