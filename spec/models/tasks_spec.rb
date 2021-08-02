require 'rails_helper'

describe User, type: :model do
  it "valid" do
    user = User.create(email: "teste@teste.com",password: "123123")
    task = Task.new(user: user)

    task.valid?

    expect(task.errors['description']).not_to be_blank
    expect(task.complete).to be false
  end
end