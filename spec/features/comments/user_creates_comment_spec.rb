require 'spec_helper'

feature 'User creates comment' do
  background do
    @user = create(:user)
    login_with_email(@user)
  end

  scenario 'with valid data', :js => true do
    a = create(:article)
    visit article_path(a.id)
    click_on 'show_comments'
    click_on 'create_comment'
    c = build(:comment)
    fill_in 'comment[content]', with: c.content
    click_on 'submit_comment'

    expect(page).to have_content(c.content)
  end

end
