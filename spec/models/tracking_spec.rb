require 'rails_helper'

describe User, type: :model do
  it "valid" do
    tracking = Tracking.new()

    tracking.valid?


    expect(tracking.errors['event']).not_to be_blank
    expect(tracking.errors['properties']).not_to be_blank
  end
end