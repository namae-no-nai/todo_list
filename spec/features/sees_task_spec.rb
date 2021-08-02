feature "delete a task on list" do
  before :each do
    user = User.create!(email: 'test@example.com', password: 'f4k3p455w0rd')
    user_2 = User.create!(email: 'abc@abc.example.com', password:'123123')
    login_as user, scope: :user

    @task_1 = Task.create!(description: 'First Post', user: user)
    @task_2 = Task.create!(description: 'Second Post', user: user)
    task_3 = Task.create!(description: 'Third Post', user: user_2)
  end

  scenario "sucessfully" do
    visit '/'
    expect(current_path).to eq(root_path)
    expect(page).to have_content 'First Post'
    expect(page).to have_content 'Second Post'
    expect(page).to_not have_content 'Third Post'
  end
end