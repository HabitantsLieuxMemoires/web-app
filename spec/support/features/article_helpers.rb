module Features
  module SessionHelpers
    def create_article(article)
      visit new_article_path
      fill_in 'article[title]', with: article.title
      fill_in 'article[body]', with: article.body
      select article.theme.title, from: 'article[theme_id]'
      click_button I18n.t('publish')
    end
  end
end
