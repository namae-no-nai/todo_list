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
    expect(Tracking.first.event).to eq("Congratulations")
    #TODO test properties
    #expect(["Great Work", "Awesome", "Mission complete", "Wowww", "Nice!!!"]).to include(Tracking.first.properties)
  end
  scenario "successfully" do
  
    visit '/'
    click_button "complete-#{@task_3.id}"
    byebug
    expect(Tracking.last.event).to eq("Shame")
    #TODO test properties
    #expect(["Great Work", "Awesome", "Mission complete", "Wowww", "Nice!!!"]).to include(Tracking.first.properties)
  end
end