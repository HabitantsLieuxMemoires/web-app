class Admin::ReportsController < Admin::BaseController
  before_action     :set_report, only: [:show, :treat, :changes]

  def index
    @reports = Report.desc(:created_at)
      .in_range(params[:date])
      .by_state(params[:state])
      .page(params[:page])
      .decorate
  end

  def show
    @tracks = ArticleHistoryTracker.where(association_chain: { 'name' => Article.name, 'id' => @report.article_id }).decorate
    @report = @report.decorate
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
