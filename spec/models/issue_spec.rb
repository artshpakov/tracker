require 'rails_helper'

RSpec.describe Issue do
  let(:regular) { create :regular }
  let(:manager) { create :manager }
  before { create_list(:issue, 3, reporter_id: regular.id) }
  before { create(:issue, assignee_id: manager.id) }

  it "regular user can only view issues reported by himself" do
    expect(regular.issues.count).to eq(Issue.where(reporter_id: regular.id).count)
  end

  it "manager can view every issue in a list" do
    expect(manager.issues.count).to eq(Issue.count)
  end
end
