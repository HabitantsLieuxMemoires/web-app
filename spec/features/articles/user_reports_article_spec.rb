require 'spec_helper'

feature 'User reports article' do

  background do
    user = create(:user)
    login_with_email(user)

    @article = create(:article)
  end

  scenario 'with valid data' do
    r = build(:report)
    create_report(@article, r)

    expect(page).to have_content(I18n.t('models.report.created'))
  end

  scenario 'with invalid data' do
    r = build(:report, description: nil)
    create_report(@article, r)

    expect(page).to have_content(I18n.t('models.report.creation_error'))
  end

end
