module ImagesHelper

  def options_for_image_size
    [
      [t('article.image.do.select_thumb'), 'thumb'],
      [t('article.image.do.select_normal'), 'normal'],
      [t('article.image.do.select_large'), 'large']
    ]
  end

end
