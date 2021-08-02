require "rails_helper"

feature "User auth" do
  context 'log in' do
    scenario "sucessfully" do
      user = User.create!(email: "teste@teste.com", password: "12345678")

      visit root_path
      click_link "Log in"
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      within 'form' do
        click_on "Log in"
      end
      
      expect(page).to have_content('Signed in successfully.')
      expect(page).not_to have_link("Log in")
      expect(page).to have_link("Log out")
      expect(current_path).to eq(root_path)
    end

    scenario 'and must fill in all fields' do
      visit root_path
      click_link "Log in"
      within 'form' do
        click_on 'Log in'
      end
      expect(page).to have_content('Invalid Email or password')
      expect(page).to have_link('Log in')
      expect(page).not_to have_link('Log out')
    end

    context 'log out' do
     scenario 'successfully' do
        user = User.create!(email: 'teste@teste.com.br', password: '12345678')

        visit root_path
        click_link "Log in"
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        within 'form' do
          click_on 'Log in'
        end
        click_on 'Log out'
  
        expect(page).to have_content('You need to sign in or sign up before continuing.')
        expect(page).to have_link('Log in')
        expect(page).not_to have_link('Log out')
        expect(current_path).to eq('/users/sign_in')
      end
    end
  
    context 'sign up' do
      scenario 'successfully' do
        visit root_path
        click_link "Log in"
        click_on ('Sign up')
        fill_in 'Email', with: 'test@test.com.br'
        fill_in 'Password', with: '12345678'
        fill_in 'Password confirmation', with: '12345678'
        within 'form' do
          click_on 'Sign up'
        end
  
        expect(page).to have_content('Welcome! You have signed up successfully.')
        expect(page).to have_link('Log out')
        expect(page).not_to have_link('Log in')
      end
    end
  end
end