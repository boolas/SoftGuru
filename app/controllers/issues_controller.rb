class IssuesController < ApplicationController
  before_action :authenticate
  before_action :can_administer?, only: [:all, :destroy]
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  # GET /issues
  def all
    @issues = Issue.all
  end

  # GET /issues
  # GET /issues.json
  def index
    @project_id = params[:project_id]
    @issues = Issue.where(project_id: params[:project_id])
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
  end

  # GET /issues/new
  def new
    @project = Project.find(params[:project_id]) unless params[:project_id].nil?
    @project_id = @project.id
    @issue = Issue.new
  end

  # GET /issues/1/edit
  def edit
    @project_id = params[:project_id]
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(issue_params)

    respond_to do |format|
      if @issue.save
        format.html { redirect_to project_issues_path(@issue.project), notice: 'Issue was successfully created.' }
        format.json { render action: 'show', status: :created, location: @issue }
      else
        format.html { render action: 'new' }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to project_issue_path(@issue.project, @issue), notice: 'Issue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to project_issues_path(@issue.project) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @project = Project.find(params[:project_id]) unless params[:project_id].nil?
      @issue = Issue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_params
      params.require(:issue).permit(:name, :description, :issue_type, :status, :project_id, :user_id, :owner_id)
    end
end
