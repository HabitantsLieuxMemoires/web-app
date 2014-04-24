class ReportDecorator < ApplicationDecorator
  delegate :id, :article

  def created_at
    object.created_at.strftime("%a %m/%d/%y")
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
