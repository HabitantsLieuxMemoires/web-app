class Admin::ChronologiesController < Admin::BaseController

  def index
    @chronologies = Chronology.by_creation_date
  end

  def new
  end

  def create
    if Chronology.create(chronology_params)
      redirect_to admin_chronologies_path, notice: t('admin.chronologies.saved')
    else
      flash[:error] = t('admin.chronologies.save_error')
      render :new
    end
  end

  private

  def chronology_params
    params.require(:chronology).permit(:title)
  end

end
