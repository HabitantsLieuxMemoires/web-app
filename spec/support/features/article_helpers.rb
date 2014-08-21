module Features
  module SessionHelpers
    def create_article(article)
      visit new_article_path
      fill_in 'article[title]', with: article.title
      fill_in 'article[body]', with: article.body
      select article.theme.title, from: 'article[theme_id]'
      select article.chronology.title, from: 'article[chronology_id]'
      click_button I18n.t('publish')
    end

    def create_report(article, report)
      visit article_path(article.id)
      click_on I18n.t('models.article.report')
      fill_in 'report[description]', with: report.description
      click_button I18n.t('report')
    end
  end
end
