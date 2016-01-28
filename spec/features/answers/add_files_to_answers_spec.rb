require_relative '../feature_helper'

feature 'Add files to answers', %q{
        In order to illustrate my answer
        As an answer's author
        I want to be able to attach files
        } do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'Authenticated user answers question with one file', js: true do
    fill_in 'Your answer', with: 'New Answer body'
    click_link 'add file'
    page.all("input[type='file']").first.set("#{Rails.root}/spec/spec_helper.rb")
    click_on 'Create'

    within '.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end

  scenario 'Authenticated user answers question with multiple files', js: true do
    fill_in 'Your answer', with: 'New Answer body'

    click_link 'add file'
    page.all("input[type='file']").first.set("#{Rails.root}/spec/spec_helper.rb")
    click_link 'add file'
    page.all("input[type='file']").last.set("#{Rails.root}/spec/rails_helper.rb")

    click_on 'Create'

    within '.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
      expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
    end
  end

  scenario 'Author of answer delete files'
end