require 'spec_helper'

feature 'Admin edits report' do
  background do
    user = create(:user, :admin)
    login_with_email(user)
  end

  scenario 'and can treat it as assigned' do
    r = create(:report)
    visit admin_report_path(r.id)
    click_on I18n.t('models.report.treat')

    expect(page).to have_content(I18n.t('models.report.treated'))
    expect(current_path).to eql(admin_reports_path)
  end

  scenario 'and can go to article and edit the content' do
    r = create(:report)
    visit admin_report_path(r.id)
    click_on I18n.t('models.article.go_to')

    expect(current_path).to eql(edit_article_path(r.article.slug))
  end

  scenario 'and can warn an article modifier about the content' do
    pending 'implement article history'
  end

  scenario 'and can see differences of each update', feature: true do
    pending 'implement diff view'
  end

end
