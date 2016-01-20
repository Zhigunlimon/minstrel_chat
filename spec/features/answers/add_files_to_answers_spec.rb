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

  scenario 'Authenticated user answers question', js: true do
    fill_in 'Your answer', with: 'New Answer body'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'

    within '.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end
end
