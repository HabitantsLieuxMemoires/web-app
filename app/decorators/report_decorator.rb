class ReportDecorator < ApplicationDecorator
  delegate :id, :description, :article_id

  def created_at(format = :short)
    l(object.created_at, format: format)
  end

  def updated_at(format = :short)
    l(object.created_at, format: format)
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
        t('admin.moderation.report.addressed')
      end
    else
      h.content_tag(:span, class: "label label-danger") do
        t('admin.moderation.report.not_addressed')
      end
    end

  end

end
