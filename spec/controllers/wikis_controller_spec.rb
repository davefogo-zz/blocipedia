require 'rails_helper'
include SessionsHelper

RSpec.describe WikisController, type: :controller do
  let(:user) {create(:user, email: "yes1@email.com")}
  let(:standard_user) {create(:user, email: "yes1@email.com")}
  let(:premium_user) {create(:user, email: "yes2@email.com")}
  let(:admin_user) {create(:user, email: "yes3@email.com")}
  let(:my_wiki) {create(:wiki)}

  context "guest" do

    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "renders the index view" do
        get :index
        expect(response).to render_template(:index)
      end

      it "assings my_wiki to @wikis" do
        get :index
        expect(assigns(:wikis)).to eq([my_wiki])
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, id: my_wiki.id
        expect(response).to have_http_status(:success)
      end

      it "renders the show view" do
        get :show, id: my_wiki.id
        expect(response).to render_template :show
      end

      it "assigns wiki to @wiki" do
        get :show, id: my_wiki.id
        expect(assigns(:wiki)).to eq(my_wiki)
      end
    end

    describe "GET new" do
      it "returns http redirect" do
        get :new
        expect(response).to redirect_to(wikis_path)
      end
    end

    describe "POST create" do
      it "returns http redirect" do
        post :create, wiki: {title: "new title", body: "new body"}
        expect(response).to redirect_to(wikis_path)
      end
    end

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, id: my_wiki.id
        expect(response).to redirect_to(wikis_path)
      end
    end

    describe "PUT update" do
      it "returns http redirect" do
        new_title = Faker::Hipster.sentence
        new_body = Faker::Hipster.paragraph

        put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to(wikis_path)
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, id: my_wiki.id
        expect(response).to redirect_to(wikis_path)
      end
    end
  end

  context "standard user attempts to do CRUD on public wikis" do
    before do
      user.standard!
      create_session(user)
    end

    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "renders the index view" do
        get :index
        expect(response).to render_template(:index)
      end

      it "assings my_wiki to @wikis" do
        get :index
        expect(assigns(:wikis)).to eq([my_wiki])
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, id: my_wiki.id
        expect(response).to have_http_status(:success)
      end

      it "renders the show view" do
        get :show, id: my_wiki.id
        expect(response).to render_template :show
      end

      it "assigns wiki to @wiki" do
        get :show, id: my_wiki.id
        expect(assigns(:wiki)).to eq(my_wiki)
      end
    end

    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the new view" do
        get :new
        expect(response).to render_template(:new)
      end

      it "instantiates @wiki" do
        get :new
        expect(:wiki).to_not be_nil
      end
    end

    describe "POST create" do
      it "creates a wiki" do
        expect{post :create, wiki: {title: "new title", body: "new body that has to be at least 20"}}.to change(Wiki, :count).by(1)
      end

      it "assigns the new wiki to @wiki" do
        post :create, wiki: {title: my_wiki.title, body: my_wiki.body}
        expect(assigns(:wiki)).to eq(Wiki.last)
      end

      it "redirects to the new wiki" do
        post :create, wiki: {title: my_wiki.title, body: my_wiki.body}
        expect(response).to redirect_to Wiki.last
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, id: my_wiki.id
        expect(response).to have_http_status(:success)
      end

      it "renders the edit view" do
        get :edit, id: my_wiki.id
        expect(response).to render_template(:edit)
      end

      it "assigns the wiki to be updated to @wiki" do
        get :edit, id: my_wiki.id

        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq(my_wiki.id)
        expect(wiki_instance.title).to eq(my_wiki.title)
        expect(wiki_instance.body).to eq(my_wiki.body)
      end
    end

    describe "PUT update" do
      it "updates wiki with expected attributes" do
        new_title = Faker::Hipster.sentence
        new_body = Faker::Hipster.paragraph

        put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}

        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq(my_wiki.id)
        expect(updated_wiki.title).to eq(new_title)
        expect(updated_wiki.body).to eq(new_body)
      end

      it "redirects to the updated wiki" do
        new_title = Faker::Hipster.sentence
        new_body = Faker::Hipster.paragraph

        put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to my_wiki
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, id: my_wiki.id
        expect(response).to redirect_to(wikis_path)
      end
    end
  end

  context "standard user attempts to do CRUD on private wikis" do
    before do
      standard_user.standard!
      create_session(standard_user)
      my_wiki.update_attributes(private: true)
    end

    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "renders the index view" do
        get :index
        expect(response).to render_template(:index)
      end

      it "assings my_wiki to @wikis" do
        get :index
        expect(assigns(:wikis)).to eq([my_wiki])
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, id: my_wiki.id
        expect(response).to have_http_status(:success)
      end

      it "renders the show view" do
        get :show, id: my_wiki.id
        expect(response).to render_template :show
      end

      it "assigns wiki to @wiki" do
        get :show, id: my_wiki.id
        expect(assigns(:wiki)).to eq(my_wiki)
      end
    end

    describe "GET new" do
      it "returns http redirect" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST create" do
      it "returns http redirect" do
        expect{post :create, wiki: {title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph}}.to change(Wiki, :count).by(1)
        expect(response).to redirect_to wikis_path
      end
    end

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, id: my_wiki.id
        expect(response).to render_template :edit
      end
    end

    describe "PUT update" do
      it "returns http redirect" do
        new_title = Faker::Hipster.sentence
        new_body = Faker::Hipster.paragraph

        put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to my_wiki
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, id: my_wiki.id
        expect(response).to redirect_to(wikis_path)
      end
    end
  end

  context "premium user attempts to do CRUD on private wikis" do
    before do
      premium_user.premium!
      create_session(premium_user)
      my_wiki.update_attributes(private: true)
    end
    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "renders the index view" do
        get :index
        expect(response).to render_template(:index)
      end

      it "assings my_wiki to @wikis" do
        get :index
        expect(assigns(:wikis)).to eq([my_wiki])
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, id: my_wiki.id
        expect(response).to have_http_status(:success)
      end

      it "renders the show view" do
        get :show, id: my_wiki.id
        expect(response).to render_template :show
      end

      it "assigns wiki to @wiki" do
        get :show, id: my_wiki.id
        expect(assigns(:wiki)).to eq(my_wiki)
      end
    end

    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the new view" do
        get :new
        expect(response).to render_template(:new)
      end

      it "instantiates @wiki" do
        get :new
        expect(:wiki).to_not be_nil
      end
    end

    describe "POST create" do
      it "creates a wiki" do
        expect{post :create, wiki: {title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph}}.to change(Wiki, :count).by(1)
      end

      it "assigns the new wiki to @wiki" do
        post :create, wiki: {title: my_wiki.title, body: my_wiki.body}
        expect(assigns(:wiki)).to eq(Wiki.last)
      end

      it "redirects to the new wiki" do
        post :create, wiki: {title: my_wiki.title, body: my_wiki.body}
        expect(response).to redirect_to Wiki.last
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, id: my_wiki.id
        expect(response).to have_http_status(:success)
      end

      it "renders the edit view" do
        get :edit, id: my_wiki.id
        expect(response).to render_template(:edit)
      end

      it "assigns the wiki to be updated to @wiki" do
        get :edit, id: my_wiki.id

        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq(my_wiki.id)
        expect(wiki_instance.title).to eq(my_wiki.title)
        expect(wiki_instance.body).to eq(my_wiki.body)
      end
    end

    describe "PUT update" do
      it "updates wiki with expected attributes" do
        new_title = Faker::Hipster.sentence
        new_body = Faker::Hipster.paragraph

        put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}

        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq(my_wiki.id)
        expect(updated_wiki.title).to eq(new_title)
        expect(updated_wiki.body).to eq(new_body)
      end

      it "redirects to the updated wiki" do
        new_title = Faker::Hipster.sentence
        new_body = Faker::Hipster.paragraph

        put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to my_wiki
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, id: my_wiki.id
        expect(response).to redirect_to(wikis_path)
      end
    end
  end

  context "admin user attempts to do CRUD on private wikis" do
    before do
      admin_user.admin!
      create_session(admin_user)
      my_wiki.update_attributes(private: true)
    end
    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "renders the index view" do
        get :index
        expect(response).to render_template(:index)
      end

      it "assings my_wiki to @wikis" do
        get :index
        expect(assigns(:wikis)).to eq([my_wiki])
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, id: my_wiki.id
        expect(response).to have_http_status(:success)
      end

      it "renders the show view" do
        get :show, id: my_wiki.id
        expect(response).to render_template :show
      end

      it "assigns wiki to @wiki" do
        get :show, id: my_wiki.id
        expect(assigns(:wiki)).to eq(my_wiki)
      end
    end

    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the new view" do
        get :new
        expect(response).to render_template(:new)
      end

      it "instantiates @wiki" do
        get :new
        expect(:wiki).to_not be_nil
      end
    end

    describe "POST create" do
      it "creates a wiki" do
        expect{post :create, wiki: {title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph, user: user}}.to change(Wiki, :count).by(1)
      end

      it "assigns the new wiki to @wiki" do
        post :create, wiki: {title: my_wiki.title, body: my_wiki.body}
        expect(assigns(:wiki)).to eq(Wiki.last)
      end

      it "redirects to the new wiki" do
        post :create, wiki: {title: my_wiki.title, body: my_wiki.body}
        expect(response).to redirect_to Wiki.last
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, id: my_wiki.id
        expect(response).to have_http_status(:success)
      end

      it "renders the edit view" do
        get :edit, id: my_wiki.id
        expect(response).to render_template(:edit)
      end

      it "assigns the wiki to be updated to @wiki" do
        get :edit, id: my_wiki.id

        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq(my_wiki.id)
        expect(wiki_instance.title).to eq(my_wiki.title)
        expect(wiki_instance.body).to eq(my_wiki.body)
      end
    end

    describe "PUT update" do
      it "updates wiki with expected attributes" do
        new_title = Faker::Hipster.sentence
        new_body = Faker::Hipster.paragraph

        put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}

        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq(my_wiki.id)
        expect(updated_wiki.title).to eq(new_title)
        expect(updated_wiki.body).to eq(new_body)
      end

      it "redirects to the updated wiki" do
        new_title = Faker::Hipster.sentence
        new_body = Faker::Hipster.paragraph

        put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to my_wiki
      end
    end

    describe "DELETE destroy" do
      it "deletes the wiki" do
        delete :destroy, id: my_wiki.id

        count = Wiki.where({id: my_wiki.id}).size
        expect(count).to eq(0)
      end

      it "redirects to the index view" do
        delete :destroy, id: my_wiki.id
        expect(response).to redirect_to wikis_path
      end
    end
  end

end
