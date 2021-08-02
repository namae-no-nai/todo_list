require 'rails_helper'

describe User, type: :model do
  it "valid" do
    user = User.new

    user.valid?

    expect(user.errors['email']).not_to be_blank  
    expect(user.errors['password']).not_to be_blank  
  end
end