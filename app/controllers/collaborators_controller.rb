class CollaboratorsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:create, :destroy]

  def create
    @user = User.find(params[:user_id])
    @wiki = Wiki.find(params[:wiki_id])

    collaborator = @user.collaborators.build(wiki: @wiki)

    if collaborator.save
      flash[:notice] = "Collaborator added."
    else
      flash[:alert] = "Collaborator removed."
    end

    redirect_to [wiki]
  end

  def authorize_user
    unless current_user && (current_user.premium? || current_user.admin?)
      flash[:alert] = "You need a standard or premium account to do that."
      redirect_to wikis_path
    end
  end
end
