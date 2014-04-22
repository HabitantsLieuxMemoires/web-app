class ReportsController < ApplicationController
  before_action :set_article, only: [:new, :create]

  def new
    render layout: false
  end

  def create
    report = Report.new(report_params)
    report.article = @article
    report.user = current_user

    if report.save
      redirect_to article_path(@article.id), notice: t('models.report.created')
    else
      redirect_to article_path(@article.id), notice: t('models.report.creation_error')
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
