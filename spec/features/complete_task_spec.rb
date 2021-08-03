require 'rails_helper'

feature "complete a task on list" do
  before :each do
    user = User.create!(email: 'test@example.com', password: 'f4k3p455w0rd')

    login_as user, scope: :user

    @task_1 = Task.create!(description: 'First Post', user: user)
    @task_2 = Task.create!(description: 'Second Post', user: user)
    @task_3 = Task.create!(description: 'Third Post', user: user ,complete: true)
  end
  scenario "successfully" do
    visit '/'
 
    click_button "complete-#{@task_1.id}"
    expect(current_path).to eq(root_path)
    expect(page).to have_content 'First Post'
    expect(page).to have_button("complete-#{@task_1.id}", :value => 'Not Complete')
    expect(page).to have_content 'Second Post'
    expect(page).to have_button("complete-#{@task_2.id}", :value => 'Complete')
    expect(page).to have_content 'Third Post'
    expect(page).to have_button("complete-#{@task_3.id}", :value => 'Not Complete')
  end

  scenario "change to not complete", js: true do
    visit '/'
    click_button "complete-#{@task_3.id}"
    expect(current_path).to eq(root_path)
    expect(page).to have_content 'First Post'
    expect(page).to have_button("complete-#{@task_1.id}", :value => 'Complete')
    expect(page).to have_content 'Second Post'
    expect(page).to have_button("complete-#{@task_2.id}", :value => 'Complete')
    expect(page).to have_content 'Third Post'
    expect(page).to have_button("complete-#{@task_3.id}", :value => 'Complete')
  end
end