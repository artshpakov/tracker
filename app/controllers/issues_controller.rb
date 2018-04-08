class IssuesController < ApplicationController
  load_and_authorize_resource

  def index
    issues = current_user.issues
    issues = issues.where(status: params[:status]) if params[:status].present?
    render json: issues
  end

  def create
    render json: current_user.issues.create(issue_params)
  end

  def update
    authorize! :update_status, @issue if params.has_key?(:status)
    if params.has_key?(:assignee_id)
      authorize! :update_assignee, @issue
      raise CanCan::AccessDenied unless params[:assignee_id].to_i.in?([0, current_user.id]) # can set assignee_id only to himself or nil
      raise CanCan::AccessDenied if params[:assignee_id].empty? && @issue.status != Issue::DefaultStatus # can unset pending issues only
    end
    render json: @issue.update(issue_params)
  end

  def destroy
    render json: @issue.destroy
  end


  protected

  def issue_params
    params.permit(:title, :description, :status, :assignee_id)
  end
end
