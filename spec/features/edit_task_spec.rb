require 'rails_helper'

feature "edit a task on list" do
  before :each do
    user = User.create!(email: 'test@example.com', password: 'f4k3p455w0rd')

    login_as user, scope: :user

    @task_1 = Task.create!(description: 'First Post', user: user)
    @task_2 = Task.create!(description: 'Second Post', user: user)
  end

  scenario "sucessfully" do


    visit '/'
    click_on "edit-#{@task_1.id}"
    fill_in "Description",	with: "Study for test"
    click_button 'Update Task' 
    expect(current_path).to eq(root_path)
    expect(page).to have_content 'Study for test'
    expect(page).to have_content 'Second Post'
    expect(page).to_not have_content 'First Post'
  end
  
  scenario "unsucessfully" do

    visit '/'
    click_on "edit-#{@task_1.id}"
    fill_in "Description",	with: ""
    click_button 'Update Task' 
    expect(page).to_not have_content 'Study for test'
    expect(page).to_not have_content 'Second Post'
    expect(page).to_not have_content 'First Post'
  end
  scenario "task from other user" do
    user_2 = User.create!(email: 'abc@abc.com', password: 'f4k3p455w0rd')
    task_3 = Task.create!(description: 'Third Post', user: user_2)

    visit '/'
    visit @task_3
    expect(current_path).to eq(root_path)
    expect(task_3.description).to eq('Third Post')
    expect(page).to_not have_content('Third Post')
  end
end