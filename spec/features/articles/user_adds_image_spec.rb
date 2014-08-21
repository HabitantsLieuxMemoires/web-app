require 'spec_helper'

feature 'User adds image' do

  background do
    user = create(:user)
    login_with_email(user)

    @article = create(:article)
  end

  scenario 'with valid image', :js => true, :focus => true do
    pending 'Find a way to attach file to upload image form'
    # image = create(:image)
    # visit edit_article_path(@article.id)

    # click_on 'show_images'
    # click_on 'add_image'

    # within '#modal-add-image' do
    #   fill_in 'image[title]', with: image.title
    #   attach_file 'image[article_image]', image.article_image
    #   click_on 'upload_image'
    # end

    # expect(page).to have_content(I18n.t('models.image.uploaded'))
  end

  scenario 'with image too big', :focus => true do
    pending 'Find a way to attach file to upload image form'
  end

  scenario 'with another file type', :focus => true do
    pending 'Find a way to attach file to upload image form'
  end

end
