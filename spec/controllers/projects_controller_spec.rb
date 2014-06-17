require 'spec_helper'

describe ProjectsController do

  describe "GET index" do
    it "assigns all projects as @projects" do
      project = FactoryGirl.create(:project)
      get :index
      expect(assigns(:projects)).to eq([project])
    end
  end


end
