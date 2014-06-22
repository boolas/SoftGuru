require 'spec_helper'

describe IssuesController do

  describe 'guest access' do
    before :each do
      @project = create(:project)
    end

    it "GET #all redirects to the login form" do
      get :all
      expect(response).to redirect_to login_url
    end

    it "GET #index redirects to the login form" do
      get :index, project_id: @project.id
      expect(response).to redirect_to login_url
    end

    it "GET #show redirects to the login form" do
      get :show, id: create(:issue), project_id: @project.id
      expect(response).to redirect_to login_url
    end

    it "GET #new redirects to the login form" do
      get :new, project_id: @project.id
      expect(response).to redirect_to login_url
    end

    it "POST #create redirects to the login form" do
      post :create, issue: attributes_for(:issue), project_id: @project.id
      expect(response).to redirect_to login_url
    end

    it "GET #edit redirects to the login form" do
      get :edit, id: create(:issue), project_id: @project.id
      expect(response).to redirect_to login_url
    end

    it "PATCH #update redirects to the login form" do
      patch :update, id: create(:issue),
            issue: attributes_for(:issue),
            project_id: @project.id
      expect(response).to redirect_to login_url
    end

    it "DELETE #destroy redirects to the login form" do
      delete :destroy, id: create(:issue), project_id: @project.id
      expect(response).to redirect_to login_url
    end
  end

  describe 'user access' do
    before :each do
      @project = create(:project)
      @user = create(:user)
      session[:user_id] = @user.id
    end

    it "GET #all denies access" do
      get :all
      expect(response).to redirect_to root_url
    end

    it "DELETE #destroy denies access" do
      delete :destroy, id: create(:issue), project_id: @project.id
      expect(response).to redirect_to root_url
    end

    describe "GET #index" do
      it "assigns all issues as @issues" do
        issue = create(:issue, project_id: @project.id)
        get :index, project_id: @project.id
        expect(assigns(:issues)).to eq([issue])
      end
    end

    describe "GET #show" do
      it "assigns the requested issue to @issue" do
        issue = create(:issue, project_id: @project.id)
        get :show, id: issue, project_id: @project.id
        expect(assigns(:issue)).to eq issue
      end
      it "renders the :show template" do
        issue = create(:issue, project_id: @project.id)
        get :show, id: issue, project_id: @project.id
        expect(response).to render_template :show
      end
    end

    describe "GET #new" do
      it "assigns a new Issue to @issue" do
        get :new, project_id: @project.id
        expect(assigns(:issue)).to be_a_new(Issue)
      end

      it "renders the :new template" do
        get :new, project_id: @project.id
        expect(response).to render_template :new
      end
    end

    describe "GET #edit" do
      it "assigns the requested issue to @issue" do
        issue = create(:issue, project_id: @project.id)
        get :edit, id: issue, project_id: @project.id
        expect(assigns(:issue)).to eq issue
      end

      it "renders the :edit template" do
        issue = create(:issue, project_id: @project.id)
        get :edit, id: issue, project_id: @project.id
        expect(response).to render_template :edit
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new issue in the database" do
          expect {
            post :create, project_id: @project.id, issue: build(:issue, project_id: @project.id).attributes.symbolize_keys#attributes_for(:issue, :project_id => @project.id)
          }.to change(Issue, :count).by(1)
        end

        it "redirects to issue#show" do
          post :create, project_id: @project.id, issue: build(:issue, project_id: @project.id).attributes.symbolize_keys
          expect(response).to redirect_to project_issues_path(@project)
        end
      end

      context "with invalid attributes" do
        it "does not save the new issue in the database" do
          expect {
            post :create, project_id: @project.id, issue: attributes_for(:invalid_issue)
          }.to_not change(Issue, :count)
        end

        it "re-renders the :new template" do
          post :create, project_id: @project.id, issue: attributes_for(:invalid_issue)
          expect(response).to render_template :new
        end
      end
    end

    describe "PATCH #update" do
      before :each do
        @issue = create(:issue, name: 'Test Issue', description: 'Test description')
      end

      context "valid attributes" do
        it "locates the requested @issue" do
          patch :update, project_id: @project.id, id: @issue, issue: attributes_for(:issue)
          expect(assigns(:issue)).to eq(@issue)
        end

        it "changes @issues's attributes" do
          patch :update, project_id: @project.id, id: @issue,
                issue: attributes_for(:issue,
                                        name: "Edited Issue",
                                        description: "New description")
          @issue.reload
          expect(@issue.name).to eq("Edited Issue")
          expect(@issue.description).to eq("New description")
        end

        it "redirects to the updated issue" do
          patch :update, project_id: @project.id, id: @issue, issue: attributes_for(:issue)
          expect(response).to redirect_to project_issue_path(@issue.project, @issue)
        end
      end

      context "with invalid attributes" do
        it "does not change the issue's attributes" do
          patch :update, project_id: @project.id, id: @issue,
                issue: attributes_for(:issue,
                                        name: nil,
                                        description: "New description")
          @issue.reload
          expect(@issue.name).to eq("Test Issue")
          expect(@issue.description).to_not eq("New description")
        end

        it "re-renders the edit template" do
          patch :update, project_id: @project.id, id: @issue,
                issue: attributes_for(:invalid_issue)
          expect(response).to render_template :edit
        end
      end
    end
  end

  describe 'admin access' do
    before :each do
      @project = create(:project)
      @user = create(:admin)
      session[:user_id] = @user.id
    end

    describe "GET #all" do
      it "assigns all issues as @issues" do
        issue = create(:issue)
        get :all
        expect(assigns(:issues)).to eq([issue])
      end
    end

    describe "GET #index" do
      it "assigns all issues as @issues" do
        issue = create(:issue, project_id: @project.id)
        get :index, project_id: @project.id
        expect(assigns(:issues)).to eq([issue])
      end
    end

    describe "GET #show" do
      it "assigns the requested issue to @issue" do
        issue = create(:issue, project_id: @project.id)
        get :show, id: issue, project_id: @project.id
        expect(assigns(:issue)).to eq issue
      end
      it "renders the :show template" do
        issue = create(:issue, project_id: @project.id)
        get :show, id: issue, project_id: @project.id
        expect(response).to render_template :show
      end
    end

    describe "GET #new" do
      it "assigns a new Issue to @issue" do
        get :new, project_id: @project.id
        expect(assigns(:issue)).to be_a_new(Issue)
      end

      it "renders the :new template" do
        get :new, project_id: @project.id
        expect(response).to render_template :new
      end
    end

    describe "GET #edit" do
      it "assigns the requested issue to @issue" do
        issue = create(:issue, project_id: @project.id)
        get :edit, id: issue, project_id: @project.id
        expect(assigns(:issue)).to eq issue
      end

      it "renders the :edit template" do
        issue = create(:issue, project_id: @project.id)
        get :edit, id: issue, project_id: @project.id
        expect(response).to render_template :edit
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new issue in the database" do
          expect {
            post :create, project_id: @project.id, issue: build(:issue, project_id: @project.id).attributes.symbolize_keys#attributes_for(:issue, :project_id => @project.id)
          }.to change(Issue, :count).by(1)
        end

        it "redirects to issue#show" do
          post :create, project_id: @project.id, issue: build(:issue, project_id: @project.id).attributes.symbolize_keys
          expect(response).to redirect_to project_issues_path(@project)
        end
      end

      context "with invalid attributes" do
        it "does not save the new issue in the database" do
          expect {
            post :create, project_id: @project.id, issue: attributes_for(:invalid_issue)
          }.to_not change(Issue, :count)
        end

        it "re-renders the :new template" do
          post :create, project_id: @project.id, issue: attributes_for(:invalid_issue)
          expect(response).to render_template :new
        end
      end
    end

    describe "PATCH #update" do
      before :each do
        @issue = create(:issue, name: 'Test Issue', description: 'Test description')
      end

      context "valid attributes" do
        it "locates the requested @issue" do
          patch :update, project_id: @issue.project, id: @issue, issue: attributes_for(:issue)
          expect(assigns(:issue)).to eq(@issue)
        end

        it "changes @issues's attributes" do
          patch :update, project_id: @issue.project, id: @issue,
                issue: attributes_for(:issue,
                                      name: "Edited Issue",
                                      description: "New description")
          @issue.reload
          expect(@issue.name).to eq("Edited Issue")
          expect(@issue.description).to eq("New description")
        end

        it "redirects to the updated issue" do
          patch :update, project_id: @issue.project, id: @issue, issue: attributes_for(:issue)
          expect(response).to redirect_to project_issue_path(@issue.project, @issue)
        end
      end

      context "with invalid attributes" do
        it "does not change the issue's attributes" do
          patch :update, project_id: @issue.project, id: @issue,
                issue: attributes_for(:issue,
                                      name: nil,
                                      description: "New description")
          @issue.reload
          expect(@issue.name).to eq("Test Issue")
          expect(@issue.description).to_not eq("New description")
        end

        it "re-renders the edit template" do
          patch :update, project_id: @issue.project, id: @issue,
                issue: attributes_for(:invalid_issue)
          expect(response).to render_template :edit
        end
      end
    end

    describe "DELETE #destroy" do
      before :each do
        @issue = create(:issue)
      end

      it "deletes the issue" do
        expect{
          delete :destroy, project_id: @issue.project, id: @issue
        }.to change(Issue, :count).by(-1)
      end

      it "redirects to issues#index" do
        delete :destroy, project_id: @issue.project, id: @issue
        expect(response).to redirect_to project_issues_path(@issue.project)
      end
    end
  end

end
