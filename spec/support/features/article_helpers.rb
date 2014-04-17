module Features
  module SessionHelpers
    def create_article(article)
      visit new_article_path
      fill_in 'article[title]', with: article.title
      fill_in 'article[body]', with: article.body
      click_button I18n.t('publish')
    end

    def create_article_with_theme(article, theme)
      visit new_article_path
      fill_in 'article[title]', with: article.title
      fill_in 'article[body]', with: article.body
      select theme.title, from: 'article[theme]'
      click_button I18n.t('publish')
    end
  end
end
