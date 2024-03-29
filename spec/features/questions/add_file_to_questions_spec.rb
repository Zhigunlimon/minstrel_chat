require_relative '../feature_helper'

feature 'Add files to questions', %q{
        In order to illustrate my question
        As an question's author
        I want to be able to attach files
        } do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'Authenticated user creates question with one file', js: true do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test body text'

    click_link 'add file'
    page.all("input[type='file']").first.set("#{Rails.root}/spec/spec_helper.rb")

    click_on 'Create question'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end

  scenario 'Authenticated user creates question with multiple files', js: true do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test body text'

    click_link 'add file'
    page.all("input[type='file']").first.set("#{Rails.root}/spec/spec_helper.rb")
    click_link 'add file'
    page.all("input[type='file']").last.set("#{Rails.root}/spec/rails_helper.rb")

    click_on 'Create question'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
  end
end