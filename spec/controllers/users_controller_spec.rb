require 'rails_helper'
include SessionsHelper

RSpec.describe UsersController, type: :controller do
  let(:my_user) {create(:user)}
  let(:new_user_attributes) do
    {
      name: "Solid Snake",
      email: "solid@email.com",
      password: "password",
      password_confirmation: "password"
    }
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "instantiates @user" do
      get :new
      expect(assigns(:user)).to_not be_nil
    end

    it "renders the new view" do
      get :new
      expect(response).to render_template :new
    end

  end

  describe "POST #create" do

    it "returns http redirect" do
      post :create, user: new_user_attributes
    end

    it "creates a new user" do
      expect{post :create, user: {name: "New name", email: "new@email.com", password: "password"}}.to change(User, :count).by(1)
    end

    it "assigns the new user to @user" do
      post :create, user: new_user_attributes
      expect(assigns(:user)).to eq(User.last)
    end

    it "sets user name properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).name).to eq(new_user_attributes[:name])
    end

    it "sets user email properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).email).to eq(new_user_attributes[:email])
    end

    it "sets user password properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).password).to eq(new_user_attributes[:password])
    end

    it "sets user password_confirmation properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).password_confirmation).to eq(new_user_attributes[:password_confirmation])
    end

    it "sets user password_confirmation properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).password_confirmation).to eq(new_user_attributes[:password_confirmation])
    end

    it "logs the user in after sign up" do
      post :create, user: new_user_attributes
      expect(session[:user_id]).to eq(assigns(:user).id)
    end
  end

end
