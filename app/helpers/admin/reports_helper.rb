module Admin::ReportsHelper

  def options_for_report_state
    [
      [t('all'), 'all'],
      [t('admin.moderation.report.addressed'), 'addressed'],
      [t('admin.moderation.report.not_addressed'), 'not_addressed']
    ]
  end

end
