require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:my_user) {create (:user)}

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instantiates  @user" do
      get :new
      expect(assigns(:user)).to_not be_nil
    end
  end

  describe "POST #create" do

    it "increases the number of users by 1" do
      expect{post :create, user: {name: my_user.name, email: my_user.email, password: my_user.password}}.to change(User, :count).by(1)
    end

    it "assigns the new user to @user" do
      post :create, user: {name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password}
      expect(assigns(:user)).to eq(User.last)
    end

  end

end
