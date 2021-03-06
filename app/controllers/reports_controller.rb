class ReportsController < ApplicationController
  before_action :set_article, only: [:new, :create]

  def new
    render layout: false
  end

  def create
    report = Report.new(report_params)
    report.article  = @article
    report.user     = current_user

    if report.save
      redirect_to article_path(@article.slug), notice: t('article.reported')
    else
      flash[:error] = t('article.report_error')
      redirect_to article_path(@article.slug)
    end
  end

  private

  def report_params
    params.require(:report).permit(:description)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end
