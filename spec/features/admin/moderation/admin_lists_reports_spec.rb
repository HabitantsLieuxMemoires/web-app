require 'spec_helper'

feature 'Admin lists reports' do
  background do
    user = create(:user, :admin)
    login_with_email(user)
  end

  scenario 'from admin dashboard', feature: true do
    visit admin_root_path
    click_on I18n.t('admin.moderation')

    expect(current_path).to eql(admin_reports_path)
  end

  scenario 'and can paginate them', feature: true do
    create_list(:report, 40)

    visit admin_reports_path

    reports = page.all('.report')
    expect(reports.size).to eq(25)

    page.find('.next_page a').click

    reports = page.all('.report')
    expect(reports.size).to eq(15)
  end

  scenario 'and can filter them by state', feature: true do
    pending
    # create_list(:report, 10, state: Report::STATES[:addressed])
    # create_list(:report, 10, state: Report::STATES[:not_addressed])

    # visit admin_reports_path
    # select I18n.t('models.report.addressed'), from: 'report[state]'
    # click_on I18n.t('filter')

    # reports = page.all('.report')
    # expect(reports.size).to eq(10)
  end

  scenario 'and can filter them by date range', feature: true do
    pending
  end

  scenario 'and can see details of one of them', feature: true do
    r = create(:report)
    visit admin_reports_path
    page.find('.report a').click

    expect(current_path).to eql(admin_report_path(r.id))
  end

end
