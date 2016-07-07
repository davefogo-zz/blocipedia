class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki created succesfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "Your wiki could not be created. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])

    if @wiki.save
      flash[:notice] = "Your wiki was updated succesfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "Your wiki could not be updated. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "Your wiki was destroyed succesfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "Your wiki could not be destroyed. Please try again."
      redirect_to @wiki
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :user)
  end
end
