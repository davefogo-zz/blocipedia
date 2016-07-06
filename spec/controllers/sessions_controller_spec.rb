require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:my_user) {create(:user)}

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST sessions" do
    it "returns http success" do
      get :create, session: {email: my_user.email}
      expect(response).to have_http_status(:success)
    end

    it "initializes" do

    end
  end

  describe "DELETE #destroy" do
    it "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end

end
