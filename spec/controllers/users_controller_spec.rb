require 'spec_helper'

describe UsersController do

  describe 'guest access' do
    it "GET #index redirects to the login form" do
      get :index
      expect(response).to redirect_to login_url
    end

    it "GET #show redirects to the login form" do
      get :show, id: create(:user)
      expect(response).to redirect_to login_url
    end

    it "GET #new redirects to the login form" do
      get :new
      expect(response).to redirect_to login_url
    end

    it "POST #create redirects to the login form" do
      post :create, user: attributes_for(:user)
      expect(response).to redirect_to login_url
    end

    it "GET #edit redirects to the login form" do
      get :edit, id: create(:user)
      expect(response).to redirect_to login_url
    end

    it "PATCH #update redirects to the login form" do
      patch :update, id: create(:user), user: attributes_for(:user)
      expect(response).to redirect_to login_url
    end

    it "DELETE #destroy redirects to the login form" do
      delete :destroy, id: create(:user)
      expect(response).to redirect_to login_url
    end
  end

  describe 'user access' do
    before :each do
      @user = create(:user)
      session[:user_id] = @user.id
    end

    it "GET #index denies access" do
      get :index
      expect(response).to redirect_to root_url
    end

    it "GET #show denies access" do
      get :show, id: create(:user)
      expect(response).to redirect_to root_url
    end

    it "GET #new denies access" do
      get :new
      expect(response).to redirect_to root_url
    end

    it "POST #create denies access" do
      post :create, user: attributes_for(:user)
      expect(response).to redirect_to root_url
    end

    it "GET #edit denies access" do
      get :edit, id: create(:user)
      expect(response).to redirect_to root_url
    end

    it "PATCH #update denies access" do
      patch :update, id: create(:user), user: attributes_for(:user)
      expect(response).to redirect_to root_url
    end

    it "DELETE #destroy denies access" do
      delete :destroy, id: create(:user)
      expect(response).to redirect_to root_url
    end

  end

  describe 'admin access' do
    before :each do
      @admin = create(:admin)
      session[:user_id] = @admin.id
    end

    describe "GET #index" do
      it "collects users into @users" do
        user = create(:user)
        get :index
        expect(assigns(:users)).to match_array [@admin,user]
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET #show" do
      it "assigns the requested user to @user" do
        user = create(:user)
        get :show, id: user
        expect(assigns(:user)).to eq user
      end
      it "renders the :show template" do
        user = create(:user)
        get :show, id: user
        expect(response).to render_template :show
      end
    end

    describe "GET #new" do
      it "sets up a new, empty user" do
        get :new
        expect(assigns(:user)).to be_a_new(User)
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "adds the user" do
          expect{
            post :create, user: attributes_for(:user)
          }.to change(User, :count).by(1)
        end

        it "redirects to users#index" do
          post :create, user: attributes_for(:user)
          expect(response).to redirect_to users_url
        end
      end
    end

    describe "GET #edit" do
      it "assigns the requested user to @user" do
        user = create(:user)
        get :edit, id: user
        expect(assigns(:user)).to eq user
      end

      it "renders the :edit template" do
        user = create(:user)
        get :edit, id: user
        expect(response).to render_template :edit
      end
    end

    describe "PATCH #update" do
      before :each do
        @user = create(:user, first_name: "John", last_name: "Smith")
      end

      context "valid attributes" do
        it "locates the requested @user" do
          patch :update, id: @user, user: attributes_for(:user)
          expect(assigns(:user)).to eq(@user)
        end

        it "changes @user's attributes" do
          patch :update, id: @user,
                user: attributes_for(:user,
                                     first_name: "Jason",
                                     last_name: "Krueger")
          @user.reload
          expect(@user.first_name).to eq("Jason")
          expect(@user.last_name).to eq("Krueger")
        end

        it "redirects to the updated user" do
          patch :update, id: @user, user: attributes_for(:user)
          expect(response).to redirect_to @user
        end
      end

      context "with invalid attributes" do
        it "does not change the user's attributes" do
          patch :update, id: @user,
                user: attributes_for(:user,
                                     first_name: "Jason",
                                     last_name: nil)
          @user.reload
          expect(@user.first_name).to_not eq("Jason")
          expect(@user.last_name).to eq("Smith")
        end

        it "re-renders the edit template" do
          patch :update, id: @user,
                user: attributes_for(:invalid_user)
          expect(response).to render_template :edit
        end
      end
    end

    describe "DELETE #destroy" do
      before :each do
        @user = create(:user)
      end

      it "deletes the user" do
        expect{
          delete :destroy, id: @user
        }.to change(User, :count).by(-1)
      end

      it "redirects to user#index" do
        delete :destroy, id: @user
        expect(response).to redirect_to users_url
      end
    end
  end

end
