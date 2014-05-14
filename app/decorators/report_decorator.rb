class ReportDecorator < ApplicationDecorator
  delegate :id, :description, :article_id

  def created_at
    object.created_at.strftime("%a %m/%d/%y")
  end

  def author
    object.user_fields['nickname']
  end

  def article
    object.article_fields['title']
  end

  def article_url
    article_path(object.article_fields['slug'])
  end

  def state
    if object.state.eql?(Report::STATES[:addressed]) then
      h.content_tag(:span, class: "label label-primary") do
        t('models.report.addressed')
      end
    else
      h.content_tag(:span, class: "label label-danger") do
        t('models.report.not_addressed')
      end
    end

  end

end
