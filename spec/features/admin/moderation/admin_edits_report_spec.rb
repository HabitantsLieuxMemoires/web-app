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

  scenario 'and can see differences of each update', js: true do
    pending 'Find a way to test history tracking'
    # a = create(:article, title: 'Old title')
    # a.update_attribute(:title, 'New title')

    # r = create(:report, article: a)
    # visit admin_report_path(r.id)

    # within '#articles-updates' do
    #   changes = all('.changes')

    #   expect(changes.size).to eq(1)
    #   click_on I18n.t('models.report.see_changes')

    #   within '#modal-see-changes' do
    #     expect(page).to have_css('.del')
    #     expect(page).to have_css('.ins')
    #   end
    # end
  end

  scenario 'and can warn an article modifier about the content' do
    pending 'implement article history'
  end

  scenario 'and can ban an article modifier' do
    pending 'implement article history'
  end

end
