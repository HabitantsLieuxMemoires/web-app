module Features
  module SessionHelpers
    def sign_up_with(email, nickname, password)
      visit signup_path
      fill_in 'user[email]', with: email
      fill_in 'user[nickname]', with: nickname
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password
      click_button 'Sign up'
    end

    def login_with(email, password)
      visit login_path
      fill_in 'Identity', with: email
      fill_in 'Password', with: password
      click_button 'Log in'
    end

    def login_with_nickname(nickname, password)
      visit login_path
      fill_in 'Identity', with: nickname
      fill_in 'Password', with: password
      click_button 'Log in'
    end

    def logout
      visit root_path
      click_on 'Log out'
    end

    def reset_password_with(identity)
      visit new_password_reset_path
      fill_in 'Identity', with: identity
      click_button 'Reset password'
    end
  end
end