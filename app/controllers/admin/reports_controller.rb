require 'pp'

class Admin::ReportsController < Admin::BaseController
  before_action     :set_report, only: [:show]

  #TODO: Reimplement search query
  def index
    if params[:date]
      range = date_params.freeze
      @reports = Report
        .between(created_at: range[0]..range[1])
        .desc(:created_at)
        .page(params[:page])
    else
      @reports = Report.desc(:created_at).page(params[:page])
    end
  end

  def show
  end

  private

  def date_params
    Hash[params[:date].split('-').map.with_index {|x, i| [i, Date.strptime(x.strip, "%m/%d/%Y")]}]
  end

  def set_report
    @report = Report.find(params[:id])
  end

end
