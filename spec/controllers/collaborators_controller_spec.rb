require 'rails_helper'
include SessionsHelper

RSpec.describe CollaboratorsController, type: :controller do
  let(:my_user) {create(:user, role: :premium)}
  let(:my_wiki) {cerate(:wiki, private: true)}

  context 'premium user' do
    before do
      create_session(my_user)
    end

    describe "POST create" do
      it "creates a collaborator for the current user and specified wiki" do
        exepct(my_user.collaborators.find_by_wiki_id(my_wiki.id)).to be_nil

        post :create, {wiki_id: my_wiki.id}

        expect(my_user.collaborators.find_by_wiki_id(my_wiki.id)).to_not be_nil
      end
    end
  end
end
