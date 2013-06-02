class MysearchesController < ApplicationController
  before_filter :load_search

  def edit
  end

  def update
    if @search.update_attributes(params[:search])
      redirect_to mysearches_path
    else
      render :action => :edit
    end
  end

  def destroy
    @search  = Search.find(params[:id])
    @search.delete
    redirect_to "/mysearches"
  end
  
  private

  def load_search
    @search  = Search.find(params[:id])
  end

  
end
