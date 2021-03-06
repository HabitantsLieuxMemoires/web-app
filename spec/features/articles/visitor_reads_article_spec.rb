require 'spec_helper'

feature 'Visitor reads article' do
  background do
    @article = create(:article)
  end

  scenario 'which exist' do
    visit article_path(@article)
    expect(current_path).to eql(article_path(@article.slug))
  end

  scenario 'wich does not exist' do
    expect {
      visit article_path('no-result-id')
    }.to raise_error(Mongoid::Errors::DocumentNotFound)
  end

  scenario 'and can see comments', js: true do
    article = create(:article_with_comments, comments_count: 10)

    visit article_path(article.id)

    # Scroll to bootom (will trigger comments loading)
    page.execute_script "window.scrollBy(0,10000)"

    within('#comments-list') do
      comments = page.all('.comment')

      expect(comments.size).to eq(10)
    end
  end

  scenario 'and cannot create comment' do
    visit article_path(@article)

    expect(page).not_to have_css('#create_comment')
  end

  scenario 'and can see images', :js => true, :focus => true do
    pending "find a way to route images in test environment"
    # image = create(:image)
    # @article.images << image
    # @article.save!

    # visit article_path(@article)
    # click_on 'show_images'

    # within('#images-list') do
    #   expect(page).to have_css('.image')
    # end
  end

  scenario 'and cannot add image', js: true do
    visit article_path(@article)
    click_on 'show_images'

    within '#images' do
      expect(page).not_to have_content(I18n.t('models.image.upload'))
    end
  end

  scenario 'and cannot update content' do
    visit article_path(@article)

    expect(page).not_to have_content(I18n.t('models.article.update'))
  end

  scenario 'and cannot signal content' do
    visit article_path(@article)

    expect(page).not_to have_content(I18n.t('models.article.report'))
  end

  scenario 'and can see marker if location set', js: true do
    a = create(:article, location: '44.853739, -0.526914')

    visit article_path(a)

    within '.leaflet-map-pane' do
      expect(all(".leaflet-marker-icon").count).to eq(1)
    end
  end

  scenario 'and can see videos', js: true do
    a = create(:article_with_videos, videos_count: 2)
    visit article_path(a)
    click_on 'show_videos'

    within '#videos-list' do
      videos = all('.video')

      expect(videos.size).to eq(2)
    end
  end

  scenario 'and cannot add video', js: true do
    visit article_path(@article)
    click_on 'show_videos'

    within '#videos' do
      expect(page).not_to have_content(I18n.t('models.video.add'))
    end
  end

end
