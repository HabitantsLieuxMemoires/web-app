require 'spec_helper'

feature 'Admin lists comments' do
  background do
    user = create(:user, :admin)
    login_with_email(user)
  end

  scenario 'and can paginate them' do
    a = create(:article_with_comments, comments_count: 20)

    visit admin_comments_path

    comments = page.all('.comment')
    expect(comments.size).to eq(10)

    page.find('.next_page a').click

    comments = page.all('.comment')
    expect(comments.size).to eq(10)
  end

  scenario 'and can view article' do
    a = create(:article_with_comments, comments_count: 1)

    visit admin_comments_path
    click_on I18n.t('models.article.view')

    expect(current_path).to eql(article_path(a))
  end

  scenario 'and can delete comment' do
    a = create(:article_with_comments, comments_count: 1)

    visit admin_comments_path
    click_on I18n.t('models.comment.delete')

    comments = page.all('.comment')
    expect(comments.size).to eq(0)
  end

end
