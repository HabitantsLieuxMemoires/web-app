class Admin::ReportsController < Admin::BaseController
  before_action     :set_report, only: [:show, :treat]

  def index
    @reports = Report.desc(:created_at)
      .in_range(params[:date])
      .by_state(params[:state])
      .page(params[:page])
      .decorate
  end

  def show
  end

  def treat
    if @report.update_attributes(state: Report::STATES[:addressed])
      redirect_to admin_reports_path, notice: t('models.report.treated')
    else
      flash[:error] = t('models.report.treat_error')
      render :show
    end
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

end
