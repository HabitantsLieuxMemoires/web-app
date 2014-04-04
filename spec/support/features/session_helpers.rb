module Features
  module SessionHelpers
    def sign_up_with(user)
      user.password ||= "password"
      visit signup_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[nickname]', with: user.nickname
      fill_in 'user[password]', with: user.password
      fill_in 'user[password_confirmation]', with: user.password
      click_button 'Sign up'
    end

    def login_with_email(user)
      user.password ||= "password"
      visit login_path
      fill_in 'Identity', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end

    def login_with_nickname(user)
      user.password ||= "password"
      visit login_path
      fill_in 'Identity', with: user.nickname
      fill_in 'Password', with: user.password
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