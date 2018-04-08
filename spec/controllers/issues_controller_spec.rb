require 'rails_helper'

RSpec.describe IssuesController, type: :controller do
  let(:manager) { create :manager }
  let(:regular) { create :regular }

  describe "issue list" do
    before { @request.headers['X-Api-Key'] = regular.api_token }

    it "is returned as an array" do
      get :index
      expect(response).to have_http_status(:success)
      expect(json_response.class).to eq Array
    end

    it "can be filtered by status" do
      create_list(:issue, rand(10), reporter_id: regular.id)
      create_list(:issue, rand(10), reporter_id: regular.id, status: Issue::StatusInProgress)
      get :index, params: {status: Issue::StatusInProgress}
      expect(response).to have_http_status(:success)
      expect(json_response.count).to eq regular.issues.where(status: Issue::StatusInProgress).count
    end
  end

  context "a regular user" do
    before { @request.headers['X-Api-Key'] = regular.api_token }

    it "can create issues" do
      expect { post :create, params: build(:issue).attributes }.to change { regular.issues.count }.by(1)
    end

    it "can update issue reported by himself" do
      issue = create :issue, reporter_id: regular.id
      expect { patch :update, params: { id: issue.id, title: "New title" } }.to change { issue.reload.title }
    end

    it "cannot update other users' issues" do
      issue = create :issue
      patch :update, params: { id: issue.id }
      expect(response).to have_http_status(:forbidden)
    end

    it "cannot update issue status" do
      issue = create :issue
      patch :update, params: { id: issue.id, status: Issue::StatusInProgress }
      expect(response).to have_http_status(:forbidden)
    end

    it "cannot update issue assignee" do
      new_regular = create(:regular)
      issue = create :issue
      patch :update, params: { id: issue.id, assignee_id: new_regular.id }
      expect(response).to have_http_status(:forbidden)
    end

    it "can delete issues reported by himself" do
      issue = create(:issue, reporter_id: regular.id)
      expect { delete :destroy, params: { id: issue.id } }.to change { regular.issues.count }.by(-1)
    end

    it "cannot delete other users' issues" do
      issue = create :issue
      delete :destroy, params: { id: issue.id }
      expect(response).to have_http_status(:forbidden)
    end
  end

  context "a manager" do
    before { @request.headers['X-Api-Key'] = manager.api_token }

    it "cannot create issues" do
      post :create, params: build(:issue).attributes
      expect(response).to have_http_status(:forbidden)
    end

    it "can update owned issues statuses" do
      issue = create :issue, assignee_id: manager.id
      expect { patch :update, params: { id: issue.id, status: Issue::StatusInProgress } }.to change { issue.reload.status }.to(Issue::StatusInProgress)
    end

    it "cannot update other managers issues statuses" do
      issue = create :issue
      patch :update, params: { id: issue.id, status: Issue::StatusInProgress }
      expect(response).to have_http_status(:forbidden)
    end

    it "can set issues to himself" do
      issue = create :issue
      expect { patch :update, params: { id: issue.id, assignee_id: manager.id } }.to change { manager.assigned_issues.count }.by(1)
    end

    it "can unset issues from himself" do
      issue = create :issue, assignee_id: manager.id
      expect { patch :update, params: { id: issue.id, assignee_id: nil } }.to change { manager.assigned_issues.count }.by(-1)
    end

    it "can unset issue assignee for pending issues only" do
      issue = create :issue, assignee_id: manager.id, status: Issue::StatusInProgress
      patch :update, params: { id: issue.id, assignee_id: nil }
      expect(response).to have_http_status(:forbidden)
    end

    it "cannot update other managers issues assignee" do
      another_manager = create(:manager)
      issue = create(:issue, assignee_id: another_manager.id)
      patch :update, params: { id: issue.id, assignee_id: manager.id }
      expect(response).to have_http_status(:forbidden)
    end

    it "cannot set issues to other managers" do
      another_manager = create(:manager)
      issue = create :issue
      patch :update, params: { id: issue.id, assignee_id: another_manager.id }
      expect(response).to have_http_status(:forbidden)
    end
  end
end
