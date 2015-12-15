require 'rails_helper'

feature 'Create answers', %q{
        In order to give answers for community
        As an authenticated user
        I want to be able to answer questions
        } do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'Authenticated user answers question' do
    sign_in(user)

    visit question_path(question)
    click_on 'Answer question'
    fill_in 'Body', with: 'New Answer body'
    click_on 'Create answer'

    expect(page).to have_content 'Your answer successfully created.'
    expect(page).to have_content 'New Answer body'
  end

  scenario 'Unauthenticated user answers question' do
    visit question_path(question)
    click_on 'Answer question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end