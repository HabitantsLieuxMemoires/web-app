module Admin::ReportsHelper

  def options_for_report_state
    [
      [t('all'), 'all'],
      [t('models.report.addressed'), 'addressed'],
      [t('models.report.not_addressed'), 'not_addressed']
    ]
  end

end
