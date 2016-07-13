class CollaboratorsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:create, :destroy]

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find(params[:user_id])

    collaborator = @user.collaborators.build(wiki: @wiki)

    if collaborator.save
      flash[:notice] = "#{@user.name} was added as a collaborator. "
    else
      flash[:alert] = "Collaborator could not be added."
    end

    redirect_to edit_wiki_path(@wiki)
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    collaborator = Collaborator.find(params[:id])

    if collaborator.destroy
      flash[:notice] = " Collaborator was removed successfully."
    else
      flash[:alert] = "Collaborator could not be removed."
    end
    redirect_to edit_wiki_path(@wiki)
  end

  def authorize_user
    unless current_user && (current_user.premium? || current_user.admin?)
      flash[:alert] = "You need a standard or premium account to do that."
    end
  end
end
