class Admin::TracksController < Admin::BaseController
  before_action :set_track, only: [:show]

  def show
    render layout: false
  end

  private

  def set_track
    @track = ArticleHistoryTracker.find(params[:id])
  end

end
