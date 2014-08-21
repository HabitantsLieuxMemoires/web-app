module ArticlesHelper

  def location_input_prepend
    content_tag(:a, fa_icon("map-marker"), href: '#', class: 'bt_fill_location')
  end

  def location_input_append(form)
      form.link_to_remove('Supprimer')
  end

end
