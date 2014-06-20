require 'spec_helper'

describe ProjectsController do

  describe "GET #index" do
    it "assigns all projects as @projects" do
      project = create(:project)
      get :index
      expect(assigns(:projects)).to eq([project])
    end
  end

  describe "GET #show" do
    it "assigns the requested project to @project" do
      project = create(:project)
      get :show, id: project
      expect(assigns(:project)).to eq project
    end
    it "renders the :show template" do
      project = create(:project)
      get :show, id: project
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    it "assigns a new Project to @project" do
      get :new
      expect(assigns(:project)).to be_a_new(Project)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    it "assigns the requested project to @project" do
      project = create(:project)
      get :edit, id: project
      expect(assigns(:project)).to eq project
    end

    it "renders the :edit template" do
      project = create(:project)
      get :edit, id: project
      expect(response).to render_template :edit
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new project in the database" do
        expect {
          post :create, project: attributes_for(:project)
        }.to change(Project, :count).by(1)
      end

      it "redirects to projects#show" do
        post :create, project: attributes_for(:project)
        expect(response).to redirect_to project_path(assigns[:project])
      end
    end

    context "with invalid attributes" do
      it "does not save the new project in the database" do
        expect {
          post :create, project: attributes_for(:invalid_project)
        }.to_not change(Project, :count)
      end

      it "re-renders the :new template" do
        post :create, project: attributes_for(:invalid_project)
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    before :each do
      @project = create(:project, name: 'Test Project', language: 'PHP')
    end

    context "valid attributes" do
      it "locates the requested @project" do
        patch :update, id: @project, project: attributes_for(:project)
        expect(assigns(:project)).to eq(@project)
      end

      it "changes @project's attributes" do
        patch :update, id: @project,
              project: attributes_for(:project,
                                      name: "Edited project",
                                      language: "C#")
        @project.reload
        expect(@project.name).to eq("Edited project")
        expect(@project.language).to eq("C#")
      end

      it "redirects to the updated project" do
        patch :update, id: @project, project: attributes_for(:project)
        expect(response).to redirect_to @project
      end
    end

    context "with invalid attributes" do
      it "does not change the project's attributes" do
        patch :update, id: @project,
              project: attributes_for(:project,
                                      name: "Edited project",
                                      language: nil)
        @project.reload
        expect(@project.name).to_not eq("Edited project")
        expect(@project.language).to eq("PHP")
      end

      it "re-renders the edit template" do
        patch :update, id: @project,
              project: attributes_for(:invalid_project)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @project = create(:project)
    end

    it "deletes the project" do
      expect{
        delete :destroy, id: @project
      }.to change(Project, :count).by(-1)
    end

    it "redirects to projects#index" do
      delete :destroy, id: @project
      expect(response).to redirect_to projects_url
    end
  end
end
