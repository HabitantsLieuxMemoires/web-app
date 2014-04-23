class Admin::ReportsController < Admin::BaseController
  before_action     :set_report, only: [:show]

  def index
    @reports = Report.desc(:created_at).page(params[:page])
  end

  def show
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

end
