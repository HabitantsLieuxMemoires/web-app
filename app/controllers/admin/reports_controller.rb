class Admin::ReportsController < Admin::BaseController
  before_action     :set_report, only: [:show]

  def index
    @reports = Report.desc(:created_at)
      .in_range(params[:date])
      .by_state(params[:state])
      .page(params[:page])
      .decorate
  end

  def show
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

end
