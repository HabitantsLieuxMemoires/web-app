module Features
  module SessionHelpers
    def sign_up_with(email, password)
      visit signup_path
      fill_in 'user[email]', with: email
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password
      click_button 'Sign up'
    end

    def login_with(email, password)
      visit root_path
      click_on 'Log in'
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Log in'
    end

    def logout
      visit root_path
      click_on 'Log out'
    end
  end
end