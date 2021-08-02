require 'rails_helper'

feature 'create a task on list' do
  scenario 'sucessfully' do
    user = User.create!(email: 'test@example.com', password: 'f4k3p455w0rd')
    
    login_as user, scope: :user

    visit '/'
    click_on 'New task'
    fill_in "Description",	with: "Test for test"
    click_button 'Create Task' 
    expect(current_path).to eq(root_path)
    expect(page).to have_content 'Test for test'
  end
  scenario "unsucessfully" do
    user = User.create!(email: 'test@example.com', password: 'f4k3p455w0rd')
    
    login_as user, scope: :user

    visit '/'
    click_on 'New task'
    click_button 'Create Task' 
    expect(current_path).to eq(tasks_path)
    expect(page).to have_content "Description can't be blank"
  end
end