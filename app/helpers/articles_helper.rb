module ArticlesHelper

  def can_add_image
    logged_in?
  end

  def can_add_video
    logged_in?
  end

end
