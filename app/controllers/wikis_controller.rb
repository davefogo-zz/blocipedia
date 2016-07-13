class WikisController < ApplicationController
  before_action :require_sign_in, except: [:index, :show]
  before_action :authorize_user, except: [:index, :show]
  before_action :authorize_admin_user, only: [:destroy]

  def index
    @wikis = Wiki.visible_to(current_user)
  end

  def show
    @wiki = Wiki.find(params[:id])

    if current_user.nil? && @wiki.private
      flash[:alert] = "You must be premium user to read private wikis."
      redirect_to wikis_path
    else
      unless @wiki.private == false || current_user.premium? || current_user == @wiki.user || current_user.collaborator_to(@wiki) || current_user.admin?
        flash[:alert] = "You must be premium user to read private wikis."
        redirect_to wikis_path
      end
    end
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    if authorized_for_private?
      flash[:alert] = "You need a premium account to do that."
    end

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
    @users = User.all

    if authorized_for_private?
      flash[:alert] = "You need a premium account to do that."
      redirect_to wikis_path
    end
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if authorized_for_private?
      flash[:alert] = "You need a premium account to do that."
    end

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

  def authorized_for_private?
    @wiki.private? && current_user.standard?
  end

  def authorize_user
    unless current_user && (current_user.standard? || current_user.premium? || current_user.admin?)
      flash[:alert] = "You need a standard or premium account to do that."
      redirect_to wikis_path
    end
  end

  def authorize_admin_user
    unless current_user.admin?
      flash[:alert] = "You need a to be an admin to do that."
      redirect_to wikis_path
    end
  end

end
