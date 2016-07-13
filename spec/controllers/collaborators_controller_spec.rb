require 'rails_helper'
include SessionsHelper

RSpec.describe CollaboratorsController, type: :controller do
  let(:my_user) {create(:user, role: :premium, email: "email@not_taken.com")}
  let(:my_wiki) {create(:wiki, private: true)}

  context 'premium user' do
    before do
      create_session(my_user)
    end

    describe "POST create" do
      it "creates a collaborator for the specified wiki" do
        expect(my_user.collaborators.find_by_wiki_id(my_wiki.id)).to be_nil

        post :create, {wiki_id: my_wiki.id, user_id: my_user.id}

        expect(my_user.collaborators.find_by_wiki_id(my_wiki.id)).to_not be_nil
      end
    end

    describe "DELETE destroy" do
      it "destroys the collaborator for the specified wiki " do
        collaborator = my_user.collaborators.where(wiki: my_wiki).create

        expect(my_user.collaborators.find_by_wiki_id(my_wiki.id)).to_not be_nil

        delete :destroy, { wiki_id: my_wiki.id, user_id: my_user.id, id: collaborator.id}

        expect(my_user.collaborators.find_by_wiki_id(my_wiki.id)).to be_nil
      end
    end
  end
end
