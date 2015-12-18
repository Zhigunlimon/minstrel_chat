require 'rails_helper'

feature 'Create answers', %q{
        In order to give answers for community
        As an authenticated user
        I want to be able to answer questions
        } do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario 'Authenticated user answers question', js: true do
    sign_in(user)

    visit question_path(question)
    fill_in 'Your answer', with: 'New Answer body'
    click_on 'Create'

    expect(page).to have_content 'New Answer body'
  end

  scenario 'Unauthenticated user answers question', js: true do
    visit question_path(question)
    fill_in 'Your answer', with: 'New Answer body'
    click_on 'Create'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end